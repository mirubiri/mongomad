module Deal
  class Offer
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :agreement
    embeds_one :composer,cascade_callbacks:true
    embeds_one :receiver,cascade_callbacks:true
    embeds_one :money

    validates :agreement,
              :composer,
              :receiver,
              presence: true
  end
end