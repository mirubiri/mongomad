class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :owner_id,   type: Moped::BSON::ObjectId
  field :owner_name, type: String
  field :text,       type: String
  has_mongoid_attached_file :image

  validates :owner_id,
            :owner_name,
            :text,
            :image,
            presence: true
end