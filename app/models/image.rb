class Image
  include Mongoid::Document

  field :url
  field :fingerprint
  field :references, type:Integer

  validates_presence_of :url, :fingerprint, :references

  validates :references, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

