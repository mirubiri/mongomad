class Deal::Agreement::Proposal::Composer
  include Mongoid::Document

  embedded_in :proposal, class_name: 'Deal::Agreement::Proposal'
  embeds_many :products, class_name: 'Deal::Agreement::Proposal::Composer::Product', cascade_callbacks: true

  field :nick,      type: String
  field :image_url, type: String

  accepts_nested_attributes_for :products

  validates :proposal,
    :products,
    :nick,
    :image_url,
    presence: true
end
