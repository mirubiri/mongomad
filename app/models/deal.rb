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

  private
  def check_number_of_users
     errors.add(:users, "Deal should have only two user_sheets.") unless users.size == 2
  end

  def check_user_equality
    errors.add(:users, "Negotiation users should not be equal.") unless users[0]._id != users[1]._id
  end

  def check_number_of_sheets
    errors.add(:user_sheets, "Deal should have only two user_sheets.") unless user_sheets.size == 2
  end

  def check_first_user_sheet
    errors.add(:user_sheets, "Deal should have one user_sheet for first user.") unless user_sheets.where(_id:users[0]._id).size == 1
  end

  def check_second_user_sheet
    errors.add(:user_sheets, "Deal should have one user_sheet for second user.") unless user_sheets.where(_id:users[1]._id).size == 1
  end

  def check_orphan_proposals
    #TODO: Fusionar las dos consultas AND+AND en una OR(AND,AND)
    errors.add(:proposals, "All proposals should be owned by both users.") unless proposals.and({ composer_id:users[0]._id }, { receiver_id:users[1].id }).size + proposals.and({ composer_id:users[1]._id }, { receiver_id:users[0].id }).size == proposals.size
  end

  def check_orphan_messages
    errors.add(:messages, "All messages should be owned by one of the users.") unless messages.or({ user_id:users[0]._id }, { user_id:users[1]._id }).size == messages.size
  end

  public
  def agreement
    proposals.last
  end
end
