class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  belongs_to :user, autosave:false

  field :name
  field :description
  field :state,      default:'available'

  validates_presence_of :user, :name, :description
  validates_inclusion_of :state, in: ['available','unavailable','ghosted','discarded' ]

  def state_machine(machine = nil)
    @state_machine ||= begin
      machine ||= MicroMachine.new(state)

      machine.when(:available, 'unavailable' => 'available')
      machine.when(:unavailable, 'available' => 'unavailable')
      machine.when(:ghost, 'available' => 'ghosted', 'unavailable' => 'ghosted')
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

  def pick(quantity)
    Product.new(name:name, description:description, images:images, quantity:quantity) do |product|
      product._id = id
      product.owner_id = user_id
    end
  end

  def sell(quantity)
    quantity <= stock &&
    begin
      self.stock -= quantity
      save
    end
  end

  def supply(quantity)
    self.stock += quantity
    save
  end

  def available?(quantity)
    stock != nil && quantity != 0 && quantity <= stock
  end
end
