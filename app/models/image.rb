class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :polymorphic_image, polymorphic: true

  has_mongoid_attached_file :file

  #,
    #:styles => {
      #:original => ['1920x1680>', :jpg],
      #:small    => ['100x100#',   :jpg],
      #:medium   => ['250x250',    :jpg],
      #:large    => ['500x500>',   :jpg]
    #}

  validates :file,
            :polymorphic_image,
            presence: true
end
