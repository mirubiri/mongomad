class Sheet
  include Mongoid::Document
  embedded_in :sheet_container, polymorphic:true
  field :name
  field :description
  validates_presence_of :name,:description
end
