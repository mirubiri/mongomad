class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  belongs_to :user, autosave:false

  field :name
  field :description
  field :state, default:'on_sale'
  field :discarded, type:Boolean, default:false

  validates_presence_of :user, :name, :description, :discarded
  validates_inclusion_of :state, in: ['on_sale','withdrawn','sold']

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

  def discard
    if discarded == false
      self.discarded = true
      true
    else
      false
    end
  end

  def undiscard
    if discarded == true
      self.discarded = false
      true
    else
      false
    end
  end
end
