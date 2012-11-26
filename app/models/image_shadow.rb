class ImageShadow
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :image_shadow_parent, polymorphic: true, inverse_of: :secondary_image

  has_mongoid_attached_file :file, preserve_files:true

  #,
    #:styles => {
      #:original => ['1920x1680>', :jpg],
      #:small    => ['100x100#',   :jpg],
      #:medium   => ['250x250',    :jpg],
      #:large    => ['500x500>',   :jpg]
    #}

  validates :file,
            :image_shadow_parent,
            presence: true
end
