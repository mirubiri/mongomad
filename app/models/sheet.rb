class Sheet
  include Mongoid::Document
  embedded_in :sheet_container, polymorphic:true
  field :name
  field :description
  field :image

  validates_presence_of :name,:description,:image
end
