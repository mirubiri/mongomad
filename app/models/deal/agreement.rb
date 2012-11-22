module Deal
  class Agreement
    include Mongoid::Document

    embedded_in :deal, class_name: 'Deal::Deal'
    embeds_many :proposals, class_name: 'Deal::Proposal'
    embeds_many :messages, class_name: 'Deal::Agreement'

    validates :deal,
              :proposals,
              presence: true
  end
end