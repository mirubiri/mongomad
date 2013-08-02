class Deal::Agreement::Proposal::Composer
  include Mongoid::Document
  include ImageManagement::ImageHolder

  embedded_in :proposal, class_name: 'Deal::Agreement::Proposal'
  embeds_many :products, class_name: 'Deal::Agreement::Proposal::Composer::Product', cascade_callbacks: true

  field :name, type: String

  accepts_nested_attributes_for :products

  validates :products,
    :name,
    presence: true
end
