class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user,autosave:false
  embeds_one :user_sheet, class_name:'UserSheet', as: :user_sheet_container

  field :text

  validates_presence_of :user, :user_sheet, :text
  validates :text, length: { minimum: 1, maximum: 160 }
end
