class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods

  field :composer_id, type:Moped::BSON::ObjectId
  field :receiver_id, type:Moped::BSON::ObjectId
  field :state,       default:'new'
  field :actionable,  type:Boolean, default:true

  validates_presence_of :goods, :composer_id, :receiver_id, :actionable
  validates_inclusion_of :state, in: ['new','signed','confirmed']

  validate :check_user_equality,
           :check_composer_goods,
           :check_receiver_goods,
           :check_orphan_goods,
           :check_duplicated_goods,
           :check_multiple_cash

  private
  def check_user_equality
    errors.add(:users, "Composer and receiver should not be equal.") unless composer_id != receiver_id
  end

  def check_composer_goods
    errors.add(:goods, "Composer should have one good at least.") unless articles(composer_id).size > 0
  end

  def check_receiver_goods
    errors.add(:goods, "Receiver should have one good at least.") unless articles(receiver_id).size > 0
  end

  def check_orphan_goods
    errors.add(:goods, "All goods should be owned by composer or receiver.") unless goods.or({ owner_id:composer_id }, { owner_id:receiver_id }).size == goods.size
  end

  def check_duplicated_goods
    errors.add(:goods, "Proposal should not have any duplicated good.") unless goods.distinct(:id).size == goods.size
  end

  def check_multiple_cash
    errors.add(:goods, "Proposal should have only one cash.") if goods.type(Cash).size > 1
  end

  public
  def composer
    proposal_container.user_sheets.find(composer_id)
  end

  def receiver
    proposal_container.user_sheets.find(receiver_id)
  end

  def articles(owner_id)
    goods.where(owner_id:owner_id)
  end

  def cash?
    goods.type(Cash).exists?
  end

  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:sign, 'new' => 'signed')
      machine.when(:confirm, 'signed' => 'confirmed')
      machine.when(:reset, 'signed' => 'new')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  def sign
    actionable? ? state_machine.trigger(:sign) : false
  end

  def confirm
    !actionable? ? false : begin
      deactivate
      state_machine.trigger(:confirm)
    end
  end

  def reset
    actionable? ? state_machine.trigger(:reset) : false
  end

  def update_state
    return false unless actionable
    if goods.where(state:'on_sale').size + goods.type(Cash).size == goods.size
      state == 'new' ? true : reset
    else
      deactivate
    end
  end

  def actionable?
    actionable
  end

  def deactivate
    !actionable ? false : begin
      self.actionable = false
      true
    end
  end
end
