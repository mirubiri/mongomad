module Attachment
  class Image
    include Mongoid::Document

    embedded_in :attachable, polymorphic:true

    field :main, type: Boolean, default:false
    field :w, type: Integer
    field :h, type: Integer
    field :x, type: Integer
    field :y, type: Integer
  end
end
