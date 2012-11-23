class Receiver
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :receiver_parent, polymorphic: true
  embeds_many :products, as: :product_parent, cascade_callbacks: true
  has_mongoid_attached_file :image, preseve_files:true


  field :user_id, type: Moped::BSON::ObjectId
  field :name, type: String

  validates :receiver_parent,
            :products,
            :user_id,
            :name,
            :image,
            presence: true
end