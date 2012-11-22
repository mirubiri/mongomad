module Negotiation
  class Offer
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :negotiation
    embeds_one :composer, cascade_callbacks:true
    embeds_one :receiver, cascade_callbacks:true
    embeds_one :money

    validates :negotiation,
              :composer,
              :receiver,
              presence: true
  end
end