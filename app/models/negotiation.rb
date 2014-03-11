class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  has_one                 :offer
  embeds_many             :user_sheets
  embeds_many             :proposals,  as: :proposal_container
  embeds_many             :messages,   as: :message_container

  field :absent_user, type:Moped::BSON::ObjectId, default:nil
  field :discarded,   type:Boolean, default:false

  validates_presence_of :users, :user_sheets, :proposals, :messages, :discarded

  validate :check_number_of_users,
           :check_user_equality,
           :check_number_of_sheets,
           :check_first_user_sheet,
           :check_second_user_sheet,
           :check_orphan_proposals,
           :check_orphan_messages

  private
  def check_number_of_users
    errors.add(:users, "Negotiation should have only two users.") unless users.size == 2
  end

  def check_user_equality
    errors.add(:users, "Negotiation users should not be equal.") unless users[0].id != users[1].id
  end

  def check_number_of_sheets
    errors.add(:user_sheets, "Negotiation should have only two user_sheets.") unless user_sheets.size == 2
  end

  def check_first_user_sheet
    errors.add(:user_sheets, "Negotiation should have one user_sheet for first user.") unless user_sheets.where(_id:users[0].id).size == 1
  end

  def check_second_user_sheet
    errors.add(:user_sheets, "Negotiation should have one user_sheet for second user.") unless user_sheets.where(_id:users[1].id).size == 1
  end

  def check_orphan_proposals
    #TODO: Fusionar las dos consultas AND+AND en una OR(AND,AND)
    errors.add(:proposals, "All proposals should be owned by both users.") unless proposals.and({ composer_id:users[0].id }, { receiver_id:users[1].id }).size + proposals.and({ composer_id:users[1].id }, { receiver_id:users[0].id }).size == proposals.size
  end

  def check_orphan_messages
    errors.add(:messages, "All messages should be owned by one of the users.") unless messages.or({ user_id:users[0].id }, { user_id:users[1].id }).size == messages.size
  end

  public
  def proposal
    proposals.last
  end

  def cash_owner?(user_id)
    proposal.cash? ? proposal.goods.type(Cash).last.owner_id == user_id : false
  end

  def gatekeeper(user_id, action)
    return false unless !discarded?
    return false if ![users.first.id, users.last.id].include?(user_id)
    return false if cash_owner?(user_id) && action == :sign
    return false if !cash_owner?(user_id) && action == :confirm
    true
  end

  def sign_proposal(user_id)
    gatekeeper(user_id, :sign) ? proposal.sign : false
  end

  def confirm_proposal(user_id)
    !gatekeeper(user_id, :confirm) ? false : begin
      discard
      proposal.confirm
    end
  end

  def discarded?
    discarded
  end

  def discard
    discarded ? false : self.discarded = true
  end
end
