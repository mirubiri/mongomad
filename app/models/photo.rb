class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Paperclip::Glue

  embedded_in :polymorphic_photo, polymorphic: true

  field :photo_file_name
  field :photo_file_size
  field :photo_content_type
  has_attached_file :photo, styles: { medium: '300x300', thumb:'100x100'}

  validates :photo, attachment_presence: true
  validates :photo, attachment_size: { greater_than:0 }
  validates :photo_file_name,:photo_content_type,:photo_file_size, presence: true
end
