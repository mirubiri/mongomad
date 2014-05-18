module Attachment
  class Image
    include Mongoid::Document

    embedded_in :attachable, polymorphic:true

    field :main, type: Boolean, default:false
    field :width, type: Integer
    field :height, type: Integer
    field :x, type: Integer
    field :y, type: Integer
  end
end
