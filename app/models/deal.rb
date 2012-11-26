class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :agreement,cascade_callbacks:true
  embeds_many :messages, as: :message_parent, cascade_callbacks: true

  validates :agreement, presence: true
end