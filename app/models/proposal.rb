class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :user_sheets
  embeds_many :goods

  field :composer_id, type:Moped::BSON::ObjectId
  field :receiver_id, type:Moped::BSON::ObjectId
  field :state,       default:'new'

  validates_presence_of :user_sheets, :goods, :composer_id, :receiver_id
  validates_inclusion_of :state, in: ['new','signed','confirmed','broken','ghosted','discarded']

  validate :check_composer_has_goods,
           :check_receiver_has_goods,
           :check_good_owner,
           :check_duplicated_good,
           :check_multiple_cash,
           :check_composer_sheet,
           :check_receiver_sheet,
           :check_sheets_number

  def check_composer_has_goods
    errors.add(:goods, "Composer should have at least one good") unless left(composer_id).count > 0
  end

  def check_receiver_has_goods
    errors.add(:goods, "Receiver should have at least one good") unless left(receiver_id).count > 0
  end

  def check_good_owner
    errors.add(:goods, "All goods should be owned by composer or receiver") unless goods.or({owner_id:composer_id}, {owner_id:receiver_id}).size == goods.size
  end

  def check_duplicated_good
    errors.add(:goods, "Proposal should not have duplicated good") unless goods.distinct(:id).size == goods.size
  end

  def check_multiple_cash
    errors.add(:goods, "Proposal should have only one cash") if goods.type(Cash).size > 1
  end

  def check_composer_sheet
    errors.add(:user_sheets, "Composer should have one user_sheet") unless user_sheets.where(_id:composer_id).size == 1
  end

  def check_receiver_sheet
    errors.add(:user_sheets, "Receiver should have one user_sheet") unless user_sheets.where(_id:receiver_id).size == 1
  end

  def check_sheets_number
    errors.add(:user_sheets, "Proposal should have only two user_sheets") unless user_sheets.size == 2
  end

  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:sign, 'new' => 'signed')

      machine.when(:confirm, 'signed' => 'confirmed')

      machine.when(:break, 'new' => 'broken',
                           'signed' => 'broken')

      machine.when(:reset, 'signed' => 'new',
                           'broken' => 'new')

      machine.when(:ghost, 'new' => 'ghosted',
                           'signed' => 'ghosted',
                           'broken' => 'ghosted')

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

  def composer
    user_sheets.find(composer_id)
  end

  def receiver
    user_sheets.find(receiver_id)
  end

  def left(owner_id)
    goods.where(owner_id:owner_id)
  end

  def right(owner_id)
    goods.where(:owner_id.ne => owner_id)
  end

  def cash?
    goods.type(Cash).exists?
  end
end
