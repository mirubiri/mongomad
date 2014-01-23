class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  embeds_many             :user_sheets
  embeds_many             :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many             :messages,  class_name:'Message', as: :message_container

  validates_presence_of :users, :user_sheets, :proposals, :messages

  validate :check_number_of_users,
           :check_user_equality,
           :check_number_of_sheets,
           :check_first_user_sheet,
           :check_second_user_sheet,
           :check_orphan_proposals,
           :check_orphan_messages

  def check_number_of_users

  end

  def check_user_equality

  end

  def check_number_of_sheets

  end

  def check_first_user_sheet

  end

  def check_second_user_sheet

  end

  def check_orphan_proposals

  end

  def check_orphan_messages

  end

  # def check_composer_sheet
  #   errors.add(:user_sheets, "Composer should have one user_sheet") unless user_sheets.where(_id:users.first._id).size == 1
  # end

  # def check_receiver_sheet
  #   errors.add(:user_sheets, "Receiver should have one user_sheet") unless user_sheets.where(_id:users.last._id).size == 1
  # end

  # def check_sheets_number
  #   errors.add(:user_sheets, "Proposal should have only two user_sheets") unless user_sheets.size == 2
  # end

  def agreement
    proposals.last
  end
end
