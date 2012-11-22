module Deal
  class Agreement
    include Mongoid::Document

    embedded_in :deal
    embeds_many :offers
    embeds_many :messages

    validates :deal,
              :offers,
              presence: true
  end
end