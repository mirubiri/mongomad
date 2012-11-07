class Thing
  #Modules
  include Mongoid::Document

  #Relations
  embedded_in :user

  #Attributes
  field :name, type: String
  field :description, type: String
  field :stock, type: Integer, default: 1

  #Validations (Relations)
  validates :user,
            presence: true

  #Validations (Attributes)
  validates :name,
            :description,
            :stock,
            presence: true

  validates :stock,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }

  #Behaviour
  #TODO: Behaviour (or DELETE)
end