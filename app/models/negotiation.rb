class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  has_one                 :offer
  embeds_many             :user_sheets
  embeds_many             :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many             :messages,  class_name:'Message',  as: :message_container

  field :state, default:'open'

  validates_presence_of :users, :user_sheets, :proposals, :messages
  validates_inclusion_of :state, in: ['open','successful','ghosted','closed']

  validate :check_number_of_users,
           :check_user_equality,
           :check_number_of_sheets,
           :check_first_user_sheet,
           :check_second_user_sheet,
           :check_orphan_proposals,
           :check_orphan_messages

  def check_number_of_users
    errors.add(:users, "Negotiation should have only two user_sheets.") unless users.size == 2
  end

  def check_user_equality
    errors.add(:users, "Negotiation users should not be equal.") unless users[0]._id != users[1]._id
  end

  def check_number_of_sheets
    errors.add(:user_sheets, "Negotiation should have only two user_sheets.") unless user_sheets.size == 2
  end

  def check_first_user_sheet
    errors.add(:user_sheets, "Negotiation should have one user_sheet for first user.") unless user_sheets.where(_id:users[0]._id).size == 1
  end

  def check_second_user_sheet
    errors.add(:user_sheets, "Negotiation should have one user_sheet for second user.") unless user_sheets.where(_id:users[1]._id).size == 1
  end

  def check_orphan_proposals
    #errors.add(:proposals, "All proposals should be owned by both users.") unless proposals.or({ composer_id:users.first._id },{ receiver_id:users.last._id }).size  == proposals.size
    #errors.add(:proposals, "All proposals should be owned by both users.") unless proposals.or({ proposals.and({ composer_id:users.first._id },{ receiver_id:users.last._id }) }, { proposals.and({ composer_id:users.last._id }, { receiver_id:users.first._id })}).size == proposals.size
  end

  def check_orphan_messages
    # errors.add(:messages, "All messages should be owned by one of the users.") unless messages.or({ user_id:users[0]._id }, { user_id:users[1]._id }).size == messages.size
  end

  # validate :check_composer_sheet,
  #          :check_receiver_sheet,
  #          :check_sheets_number

  # def check_composer_sheet
  #   errors.add(:user_sheets, "Composer should have one user_sheet") unless user_sheets.where(_id:users.first._id).size == 1
  # end

  # def check_receiver_sheet
  #   errors.add(:user_sheets, "Receiver should have one user_sheet") unless user_sheets.where(_id:users.last._id).size == 1
  # end

  # def check_sheets_number
  #   errors.add(:user_sheets, "Proposal should have only two user_sheets") unless user_sheets.size == 2
  # end

  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:success, 'open' => 'successful')

      machine.when(:ghost, 'open' => 'ghosted')

      machine.when(:close, 'ghosted' => 'closed')

      machine.when(:reset, 'ghosted' => 'open')

      machine.when(:reopen, 'closed' => 'open')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  def success
    state_machine.trigger(:success)
  end

  def ghost
    state_machine.trigger(:ghost)
  end

  def close
    state_machine.trigger(:close)
  end

  def reset
    state_machine.trigger(:reset)
  end

  def reopen
    state_machine.trigger(:reopen)
  end

  def sign_proposal(user_id)
    if gatekeeper(user_id, :sign)
      proposal.sign
    else
      false
    end
  end

  def confirm_proposal(user_id)
    if gatekeeper(user_id, :confirm)
      proposal.confirm
    else
      false
    end
  end

  def break_proposal
    proposal.break
  end

  def reset_proposal
    proposal.reset
  end

  def ghost_proposal
    proposal.ghost
  end

  def discard_proposal
    proposal.discard
  end

  def gatekeeper(user_id, action)
    return false if state != 'open'
    return false if ![proposal.composer_id, proposal.receiver_id].include? user_id

    return false if money_owner?(user_id) && action == :sign
    return false if !money_owner?(user_id) && action == :confirm

    true
  end

  def proposal
    proposals.last
  end

  def money_owner?(user_id)
    if proposal.cash?
      proposal.goods.type(Cash).last.owner_id == user_id
    else
      false
    end
  end
end
