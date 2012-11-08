class User
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :profile
  embeds_many :things
  embeds_many :requests
  has_and_belongs_to_many :sent_offers, class_name: "Offer", inverse_of: nil
  has_and_belongs_to_many :received_offers, class_name: "Offer", inverse_of: nil
  has_and_belongs_to_many :negotiations, inverse_of: nil
  has_and_belongs_to_many :deals, inverse_of: nil

  validates :profile, presence: true

end