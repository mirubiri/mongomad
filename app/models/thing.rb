class Thing

  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user
  embeds_one :main_photo, class_name:'Photo'
  embeds_many :photos, as: :polymorphic_photo

  #Attributes
  #TODO: Attributes (or DELETE)
  field :name, type: String
  field :description, type: String
  field :stock, type: Integer, default: 1

  #Validations (Relations)
  validates :main_photo,
            presence: true

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)
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
  #TODO: Behaviour (or DELETE)

end