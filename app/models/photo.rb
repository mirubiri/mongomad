=begin
class Photo

  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps
  include Paperclip::Glue

  #Relations
  embedded_in :polymorphic_photo, polymorphic: true

  #Attributes
  #TODO: Attributes (or DELETE)
  has_attached_file :photo, styles: { medium: '300x300', thumb:'100x100'}
  field :photo_file_name
  field :photo_file_size
  field :photo_content_type

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)
  validates :photo,
            attachment_presence: true,
            attachment_size: { greater_than:0 }

  validates :photo_file_name,
            :photo_file_size,
            :photo_content_type,
            presence: true

  #Behaviour
  #TODO: Behaviour (or DELETE)

end
=end