class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :agreement, class_name: "Deal::Agreement", cascade_callbacks: true
  embeds_many :messages, class_name: "Deal::Message", cascade_callbacks: true

  validates :agreement,
            presence: true
end
