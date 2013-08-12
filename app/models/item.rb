class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  embeds_one  :sheet, class_name:'ItemSheet', as: :sheet_container

  field :stock,type:Integer

  validates_presence_of :sheet,:stock

  validates :stock, allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end