class Negotiation::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation
  embeds_one  :composer, class_name: 'Negotiation::Proposal::Composer', cascade_callbacks: true
  embeds_one  :receiver, class_name: 'Negotiation::Proposal::Receiver', cascade_callbacks: true
  embeds_one  :money,    class_name: 'Negotiation::Proposal::Money', cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId
  field :state,            type: Symbol, default: :not_signed

  accepts_nested_attributes_for :composer, :receiver, :money

  validates :composer,
    :receiver,
    :money,
    :user_composer_id,
    :user_receiver_id,
    :state,
    presence: true

  validates :state,
    :inclusion => { :in => [:not_signed, :signed_by_composer, :signed_by_receiver, :confirmed] }

  def user_composer
    negotiation && negotiation.negotiators.find(user_composer_id)
  end

  def user_receiver
    negotiation && negotiation.negotiators.find(user_receiver_id)
  end

  def allowed_actions
    actions = {
      composer: [:new],
      receiver: [:new]
    }

    proposal_type = type_of
    case proposal_type
    when :composer_offers_money
      case state
      when :not_signed
        actions[:receiver] << :sign
      when :signed_by_receiver
        actions[:composer] << :confirm
        actions[:receiver] << :unsign
      end
    when :receiver_offers_money
      case state
      when :not_signed
        actions[:composer] << :sign
      when :signed_by_composer
        actions[:receiver] << :confirm
        actions[:composer] << :unsign
      end
    when :no_one_offers_money
      case state
      when :signed_by_composer
        actions[:composer] << :unsign
        actions[:receiver] << :confirm
      end
    end
    actions
  end

  def type_of
    case money.user_id
      when user_composer_id
        :composer_offers_money
      when user_receiver_id
        :receiver_offers_money
      when nil
        :no_one_offers_money
    end
  end
end
