class User

  #Modules
  include Mongoid::Document

  #Relations
  embeds_one :profile
  embeds_many :things
  has_and_belongs_to_many :offer_inbox, class_name: "Offer", inverse_of: nil
  has_and_belongs_to_many :offer_outbox, class_name: "Offer", inverse_of: nil
  has_and_belongs_to_many :negotiations, inverse_of: nil
  has_and_belongs_to_many :deals, inverse_of: nil

  #Attributes
  #TODO: Attributes (or DELETE)
  field :name, type: String

  #Validations (Relations)
  validates :profile,
            presence: true

  #Validations (Attributes)
  #TODO: Validations Attributes(or DELETE)

  #Behaviour
  #TODO: Behaviour (or DELETE)

end