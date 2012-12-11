class Deal::Agreement::Proposal::Receiver
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"
  embeds_many :products, class_name: "Deal::Agreement::Proposal::Receiver::Product", cascade_callbacks: true

  field :user_id, type: Moped::BSON::ObjectId
  field :name,    type: String
  has_mongoid_attached_file :image

  validates :proposal,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end
