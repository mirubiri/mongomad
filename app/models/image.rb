class Image
  include Mongoid::Document

#   field :url,         type:String
#   field :fingerprint, type:String
#   field :references,  type:Integer

#   validates :url,
#     :fingerprint,
#     :references,
#     presence: true

#   validates :references,
#     allow_nil: false,
#     numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
  