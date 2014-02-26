class Product < Good
  include AutoUpdate

  field :_id,        type:Moped::BSON::ObjectId, default:nil
  field :name
  field :description
  field :owner_id,   type:Moped::BSON::ObjectId
  field :state,      default:'on_sale'

  auto_update :name, :description, :images, using: :item

  validates_presence_of :_id, :name, :description, :owner_id
  validates_inclusion_of :state, in: ['on_sale','withdrawn','sold']

  def item
    Item.find(_id)
  end

  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:withdraw, 'on_sale' => 'withdrawn')
      machine.when(:sell, 'on_sale' => 'sold')

      machine.on(:any) do
        self.state = @state_machine.state
      end
      machine
    end
  end

  def withdraw
    state_machine.trigger(:withdraw)
  end

  def sell
    state_machine.trigger(:sell)
  end
end
