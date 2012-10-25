class Thing

  #Modules
  include Mongoid::Document
  include Mongoid::Timestamps

  #Relations
  embedded_in :thing_box
  #embeds_one :main_photo, class_name:'Photo', as: :polymorphic_photo, cascade_callbacks: true
  #embeds_many :photos, as: :polymorphic_photo, cascade_callbacks: true

  #Attributes
  field :name, type: String
  field :description, type: String
  field :stock, type: Integer, default: 1

  #Validations
  validates :thing_box,
            :name,
            :description,
            :stock,
            presence: true

  validates :stock,
            allow_nil: false,
            numericality: { greater_than_or_equal_to: 0,
                            only_integer:true }

  #Behaviour
end

=begin
  def owner
    thing_box.user
  end

  def to_product
    p=Product.new
    #p.main_photo=main_photo
    p.name=name
    p.description=description
    #p.photos=photos.dup
    p.thing_id=_id
    p.quantity=nil
    return p
  end
=end
