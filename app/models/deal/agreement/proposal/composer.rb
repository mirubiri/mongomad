class Deal::Agreement::Proposal::Composer
  include Mongoid::Document


  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"
  embeds_many :products, class_name: "Deal::Agreement::Proposal::Composer::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String

  mount_uploader :image, UserImageUploader

  validates :proposal,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end
