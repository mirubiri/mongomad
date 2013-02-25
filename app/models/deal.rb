class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :agreement, class_name: "Deal::Agreement", cascade_callbacks: true

  has_and_belongs_to_many :users

  validates :agreement,
    :users,
    presence: true
end
