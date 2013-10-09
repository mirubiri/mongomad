module Attachment
  module Images
    extend ActiveSupport::Concern
    included do
      embeds_many :images,class_name: "Attachment::Image",as: :attachable
    end
  end
end