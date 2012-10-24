class Offer
  include Mongoid::Document
  belongs_to :offer_inbox
  belongs_to :offer_outbox
  embeds_one :money
  embeds_one :composer
  embeds_one :receiver
  validates :offer_inbox, :offer_outbox, :composer, :receiver, presence: true
end
