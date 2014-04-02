class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  belongs_to :user, autosave:false

  field :name
  field :description
  field :state,      default:'on_sale'
 # field :discarded,  type:Boolean, default:false

  validates_presence_of  :user#, :discarded
  validates_length_of    :name, minimum: 1, maximum: 20
  validates_length_of    :description, minimum: 1, maximum: 200
  validates_inclusion_of :state, in: ['on_sale','withdrawn','sold']

  def to_product
    Product.new(name:name, description:description, owner_id:user_id, images:images) do |product|
      product.id = id
    end
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
    discarded? ? false : begin
      discard
      state_machine.trigger(:withdraw)
    end
  end

  def sell
    discarded? ? false : begin
      discard
      state_machine.trigger(:sell)
    end
  end

  # def discard
  #   discarded? ? false : self.discarded = true
  # end
end
