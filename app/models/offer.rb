class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user_sender,   class_name: 'User', inverse_of: :sent_offers
  belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers

  embeds_one :proposal, as: :polymorphic_proposal
  embeds_many :user_sheets

  field :message

  validates_presence_of :user_sender, :user_receiver, :proposal, :message

  validates :message, length: { minimum: 1, maximum: 160 }

  def sender
    user_sheets.find(user_sender_id)
  end

  def receiver
    user_sheets.find(user_receiver_id)
  end
end
