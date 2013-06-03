class Negotiation::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation
  embeds_one  :composer, class_name: 'Negotiation::Proposal::Composer', cascade_callbacks: true
  embeds_one  :receiver, class_name: 'Negotiation::Proposal::Receiver', cascade_callbacks: true
  embeds_one  :money,    class_name: 'Negotiation::Proposal::Money', cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId

  accepts_nested_attributes_for :composer, :receiver, :money

  before_create :set_initial_state

  state_machine :confirmable_state, :initial => :confirmable do
    event :unconfirmable do
      transition :confirmable => :unconfirmable, :unless => :confirmed?
    end

    event :confirmable do
      transition :unconfirmable => :confirmable
    end
  end

  state_machine :state, :initial => nil do
    event :sign_receiver do
      transition :unsigned => :receiver_signed
    end

    event :confirm_composer do
      transition :receiver_signed => :composer_confirmed, :if => :confirmable?
    end

    event :confirm_receiver do
      transition :composer_signed => :receiver_confirmed, :if => :confirmable?
    end

    event :cancel_composer do
      transition [:unsigned, :composer_signed, :receiver_signed] => :composer_canceled
    end

    event :cancel_receiver do
      transition [:unsigned ,:composer_signed, :receiver_signed] => :receiver_canceled
    end
  end

  validates :composer,
   :receiver,
   :money,
   :user_composer_id,
   :user_receiver_id,
   :confirmable_state,
   presence: true

  def user_composer
    negotiation && negotiation.negotiators.find(user_composer_id)
  end

  def user_receiver
    negotiation && negotiation.negotiators.find(user_receiver_id)
  end

  def can_sign?(user)
    user_receiver_id == user.id && state == 'unsigned'
  end

  def can_confirm?(user)
    (user_composer_id == user.id && state == 'receiver_signed') || (user_receiver_id == user.id && state == 'composer_signed')
  end

  def can_cancel?(user)
    state == 'unsigned' || state == 'receiver_signed' || state == 'composer_signed'
  end

  private
  def set_initial_state
    if money.user_id == user_composer_id
      self.state = :unsigned
    else
      self.state = :composer_signed
    end
  end

  public
  def seal_deal
    deal = nil

    if self.negotiation.persisted?
      deal_params = {
        signers: self.negotiation.negotiators,
        conversation_attributes: {
          messages_attributes: Array.new
        },
        agreement_attributes: fill_agreement_hash
      }

      deal = Deal.new(deal_params)
      deal.save
    end

    deal
  end

  private
  def fill_agreement_hash
    agreement_hash = {
      conversation_attributes: fill_conversation_hash,
      proposals_attributes: Array.new
    }

    self.negotiation.proposals.each do |proposal|
      agreement_hash[:proposals_attributes] << fill_proposal_hash(proposal)
    end

    agreement_hash
  end

  def fill_conversation_hash
    conversation_hash = {
      messages_attributes: Array.new
    }

    self.negotiation.conversation.messages.each do |message|
      conversation_hash[:messages_attributes] << fill_message_hash(message)
    end

    conversation_hash
  end

  def fill_message_hash(message)
    message_hash = {
      user_id: message.user_id,
      nick: message.nick,
      text: message.text,
      image_url: message.image_url,
      image_fingerprint: message.image_fingerprint
    }
  end

  def fill_proposal_hash(proposal)
    proposal_hash = {
      user_composer_id: self.user_composer_id,
      user_receiver_id: self.user_receiver_id,
      composer_attributes: {
        nick: user_composer.profile.nick,
        image_url: user_composer.profile.image_url,
        image_fingerprint: user_composer.profile.image_fingerprint,
        products_attributes: Array.new
      },
      receiver_attributes: {
        nick: user_receiver.profile.nick,
        image_url: user_receiver.profile.image_url,
        image_fingerprint: user_receiver.profile.image_fingerprint,
        products_attributes: Array.new
      },
      money_attributes: {
        user_id: self.money.user_id,
        quantity: self.money.quantity
      }
    }

    #TODO: Unir ambas inicializaciones composer/receiver
    self.composer.products.each do |product|
      thing = proposal.user_composer.things.find(product.thing_id)
      proposal_hash[:composer_attributes][:products_attributes] << {
        thing_id: product.thing_id,
        name: thing.name,
        description: thing.description,
        quantity: product.quantity,
        image_url: thing.image_url,
        image_fingerprint: thing.image_fingerprint
      }
    end

    self.receiver.products.each do |product|
      thing = proposal.user_receiver.things.find(product.thing_id)
      proposal_hash[:receiver_attributes][:products_attributes] << {
        thing_id: product.thing_id,
        name: thing.name,
        description: thing.description,
        quantity: product.quantity,
        image_url: thing.image_url,
        image_fingerprint: thing.image_fingerprint
      }
    end

    proposal_hash
  end
end
