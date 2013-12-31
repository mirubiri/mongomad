class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users
  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message',  as: :message_container

  field :state, default:'open'

  validates_presence_of :proposals, :state
  validates_inclusion_of :state, in: ['open','successful','ghosted','closed']

  def state_machine(machine=nil)
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
    if state == 'open'
      if user_id == composer || user_id == receiver
        if action == :sign 
          if money_owner(user_id)
            return false
          else
            return true
          end
        end

        if action == :confirm
          if money_owner(user_id)
            return true
          else
            return false
          end
        end

        if action != :sign && action != :confirm
          return true
        end
      else
        return false
      end
    else
      return false
    end
  end

  def proposal
    proposals.last
  end

  def composer
    proposal.composer_id
  end

  def receiver
    proposal.receiver_id
  end

  def money_owner(user_id)
    if proposal.cash?
      proposal.goods.type(Cash).last.owner_id == user_id
    else
      return false
    end
  end
end
