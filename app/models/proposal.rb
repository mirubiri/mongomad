class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods

  field :composer_id, type:Moped::BSON::ObjectId
  field :receiver_id, type:Moped::BSON::ObjectId
  field :state,       default:'new'

  validates_presence_of :goods, :composer_id, :receiver_id
  validates_inclusion_of :state, in: ['new','signed','confirmed','broken','ghosted','discarded']

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
    errors.add(:goods, "Composer should have at least one good.") unless products(composer_id).size > 0
  end

  def check_receiver_goods
    errors.add(:goods, "Receiver should have at least one good.") unless products(receiver_id).size > 0
  end

  def check_orphan_goods
    errors.add(:goods, "All goods should be owned by composer or receiver.") unless goods.or({ owner_id:composer_id }, { owner_id:receiver_id }).size == goods.size
  end

  def check_duplicated_goods
    errors.add(:goods, "Proposal should not have any duplicated good.") unless goods.distinct(:id).size == goods.size
  end

  def check_multiple_cash
    errors.add(:goods, "Proposal should not have more than one cash.") if goods.type(Cash).size > 1
  end

  public
  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:sign, 'new' => 'signed')
      machine.when(:confirm, 'signed' => 'confirmed')
      machine.when(:break, 'new' => 'broken', 'signed' => 'broken')
      machine.when(:reset, 'signed' => 'new', 'broken' => 'new')
      machine.when(:ghost, 'new' => 'ghosted', 'signed' => 'ghosted', 'broken' => 'ghosted')
      machine.when(:discard, 'ghosted' => 'discarded')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  def sign
    state_machine.trigger(:sign)
  end

  def confirm
    state_machine.trigger(:confirm)
  end

  def break
    state_machine.trigger(:break)
  end

  def reset
    state_machine.trigger(:reset)
  end

  def ghost
    state_machine.trigger(:ghost)
  end

  def discard
    state_machine.trigger(:discard)
  end

  def update_state
    if ['new', 'signed', 'broken'].include?(state)
      if goods.where(state:'available').size + goods.type(Cash).size == goods.size
        reset
      elsif (goods.where(state:'unavailable').size > 0) && (goods.or({ state:'ghosted' }, { state:'discarded' }).size == 0)
        self.break
      else
        ghost
      end
    else
      false
    end
  end

  def composer
    proposal_container.user_sheets.find(composer_id)
  end

  def receiver
    proposal_container.user_sheets.find(receiver_id)
  end

  def products(owner_id)
    goods.where(owner_id:owner_id)
  end

  def cash?
    goods.type(Cash).exists?
  end
end
