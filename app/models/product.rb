class Product < Good
  include AutoUpdate

  field :_id,        type:Moped::BSON::ObjectId, default:nil
  field :name
  field :description
  field :owner_id,   type:Moped::BSON::ObjectId
  field :quantity,   type:Integer
  field :state,      default:'available'

  validates_presence_of :_id, :name, :description, :owner_id
  validates :quantity, allow_nil: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_inclusion_of :state, in: ['available','unavailable','ghosted','discarded']

  auto_update :name,:description,:images, using: :item

  def state_machine(machine=nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:available, 'available' => 'unavailable')

      machine.when(:unavailable, 'unavailable' => 'available')

      machine.when(:ghost, 'available' => 'ghosted',
                           'unavailable' => 'ghosted')

      machine.when(:discard, 'ghosted' => 'discarded')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  def available
    state_machine.trigger(:available)
  end

  def unavailable
    state_machine.trigger(:unavailable)
  end

  def ghost
    state_machine.trigger(:ghost)
  end

  def discard
    state_machine.trigger(:discard)
  end

  def item
    Item.find(_id)
  end

  def sell
    self.item.sell(quantity)
  end

  def available?
    self.item.available?(self.quantity)
  end
end