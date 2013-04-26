class Image
  include Mongoid::Document
  field :hash, type:String
  field :references, type:Integer
  field :url, type:String
end
