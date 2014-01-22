class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  has_one                 :offer
  embeds_many             :user_sheets
  embeds_many             :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many             :messages,  class_name:'Message',  as: :message_container

  field :state, default:'open'

  validates_presence_of :users, :user_sheets, :proposals
  validates_inclusion_of :state, in: ['open','successful','ghosted','closed']

  validate :check_composer_sheet,
           :check_receiver_sheet,
           :check_sheets_number

  def check_composer_sheet
    errors.add(:user_sheets, "Composer should have one user_sheet") unless user_sheets.find(_id:user_composer_id).size == 1
  end

  def check_receiver_sheet
    errors.add(:user_sheets, "Receiver should have one user_sheet") unless user_sheets.find(_id:user_receiver_id).size == 1
  end

  def check_sheets_number
    errors.add(:user_sheets, "Proposal should have only two user_sheets") unless user_sheets.size == 2
  end

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
