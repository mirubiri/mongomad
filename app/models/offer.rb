class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  belongs_to  :negotiation
  embeds_many :user_sheets, class_name: 'UserSheet', as: :user_sheet_container
  embeds_one  :proposal,      as: :proposal_container

  field :message

  private :users,:proposal,:user_sheets,:user_ids

  def add_participant(user)
    users<<user
    user_sheets<<user.sheet
  end

  def composer
    user_sheets.where(id:proposal.composer)
  end

end
