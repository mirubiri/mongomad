module Deal
  class Agreement
    include Mongoid::Document

    embedded_in :deal, class_name: 'Deal::Deal'
    embeds_many :offers, class_name: 'Deal::offer'
    embeds_many :messages, class_name: 'Deal::Agreement'

    validates :deal,
              :offers,
              presence: true
  end
end