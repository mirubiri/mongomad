class Negotiation::Token
  include Mongoid::Document

  embedded_in :negotiation

  field :user_id, type: Moped::BSON::ObjectId
  field :state,   type: Symbol

  validates :user_id,
    :state,
    presence: true

  validates :state,
    :inclusion => { :in => [:propose, :accept] }

  def initialize_token
    proposal = self.negotiation.proposals.last

    if proposal.money.user_id == proposal.user_receiver.id
      self.user_id = proposal.user_composer.id
    else
      self.user_id = proposal.user_receiver.id
    end
    self.state = :propose
  end

  def update_token(user_id, state)
    self.user_id = user_id
    self.state = state
  end
end
