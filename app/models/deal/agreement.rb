class Deal::Agreement
  include Mongoid::Document

  embedded_in :deal
  embeds_many :proposals, class_name: "Deal::Agreement::Proposal", cascade_callbacks: true

  validates :deal,
    :proposals,
    presence: true
end
