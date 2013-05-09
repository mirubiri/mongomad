class Image
  include Mongoid::Document

  field :url,         type:String
  field :fingerprint, type:String
  field :references,  type:Integer
end
