class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods
  embeds_many :user_sheets

  field :composer_id, type:Moped::BSON::ObjectId
  field :receiver_id, type:Moped::BSON::ObjectId

  validates_presence_of :composer_id, :receiver_id

  validate :check_composer_have_goods,
           :check_receiver_have_goods,
           :check_goods_owner,
           :check_duplicated_goods,
           :check_multiple_cash,
           :check_composer_sheet,
           :check_receiver_sheet,
           :check_sheets_number

  def state_machine(machine=nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new('unsigned')
      machine.when(:sign,'unsigned'=>'signed')
      machine.when(:confirm,'signed'=>'confirmed')
      machine.on(:any) do
        self.state=@state_machine.state
      end
      machine
    end
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

  private
  def check_composer_have_goods
    errors.add(:goods, "Composer should have at least one good") unless left(composer_id).count > 0
  end

  def check_receiver_have_goods
    errors.add(:goods, "Receiver should have at least one good") unless left(receiver_id).count > 0
  end

  def check_goods_owner
    errors.add(:goods, "All goods should be owned by composer or receiver") unless goods.or({owner_id:composer_id}, {owner_id:receiver_id}).size == goods.size
  end

  def check_duplicated_goods
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
end
