class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user_composer, class_name: 'User', inverse_of: :sent_offers
  belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers

  embeds_one :proposal, as: :proposal_container

  field :message

  validates_presence_of :user_composer, :user_receiver, :proposal, :message

  validates :message, length: { minimum: 1, maximum: 160 }

  def composer
    user_sheets.find(user_composer_id)
  end

  def receiver
    user_sheets.find(user_receiver_id)
  end

  def negotiate
    persisted? && Negotiation.create(_users:[user_composer, user_receiver], proposals:[proposal], user_sheets:user_sheets)
  end
end
