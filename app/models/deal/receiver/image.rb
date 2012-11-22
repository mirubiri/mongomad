module Deal
  module Receiver
    class Image
      include Mongoid::Document
      include Mongoid::Paperclip

      embedded_in :product, class_name: 'Deal::Receiver::Product'

      has_mongoid_attached_file :file

      #,
        #:styles => {
          #:original => ['1920x1680>', :jpg],
          #:small    => ['100x100#',   :jpg],
          #:medium   => ['250x250',    :jpg],
          #:large    => ['500x500>',   :jpg]
        #}

      validates :file,
                :product,
                presence: true
    end
  end
end