class UserSheet
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user_sheet_container,polymorphic:true

  field :first_name
  field :last_name
  field :nick

  validates_presence_of :first_name,:last_name,:nick
end
