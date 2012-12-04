class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :user_id,   type: Moped::BSON::ObjectId
  field :user_name, type: String
  field :text,       type: String
  has_mongoid_attached_file :image, preserve_files: true

  validates :user_id,
            :user_name,
            :text,
            :image,
            presence: true
end