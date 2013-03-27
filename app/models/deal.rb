class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :signers, class_name: "User"

  embeds_one :conversation, class_name: "Deal::Conversation", cascade_callbacks: true
  embeds_one :agreement,    class_name: "Deal::Agreement", cascade_callbacks: true

  accepts_nested_attributes_for :conversation, :agreement

  validates :signers,
    :conversation,
    :agreement,
    presence: true
end
