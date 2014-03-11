class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user,       autosave:false
  embeds_one :user_sheet, as: :user_sheet_container

  field :text

  validates_presence_of :user, :user_sheet
  validates_length_of :text, minimum: 1, maximum: 160

  validate :check_user_sheet

  private
  def check_user_sheet
    errors.add(:user_sheets, "Request should have one user_sheet for user.") unless user_id == user_sheet.id
  end
end
