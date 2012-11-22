module Negotiation
  class offer
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :negotiation #, class_name: 'Negotiation::negotiation'
    embeds_one :composer, cascade_callbacks:true
    embeds_one :receiver, cascade_callbacks:true
    embeds_one :money

    validates :negotiation,
              :composer,
              :receiver,
              presence: true
  end
end