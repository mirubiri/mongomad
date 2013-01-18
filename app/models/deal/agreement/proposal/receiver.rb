class Deal::Agreement::Proposal::Receiver
  include Mongoid::Document
  

  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"
  embeds_many :products, class_name: "Deal::Agreement::Proposal::Receiver::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String
  mount_uploader :image, UserImageUploader

  validates :proposal,
            :products,
            :user_id,
            :name,
            presence: true
end
