class Negotiation::Conversation
  include Mongoid::Document

  embedded_in :negotiation
  embeds_many :messages, class_name: "Negotiation::Conversation::Message", cascade_callbacks: true

  field :starter_negotiator_name,  type: String
  field :follower_negotiator_name, type: String

  # mount_uploader :starter_image,  ProductImageUploader, :mount_on => :starter_negotiator_image_name
  # mount_uploader :follower_image, ProductImageUploader, :mount_on => :follower_negotiator_image_name

  validates :negotiation,
    :messages,
    :starter_negotiator_name,
    :follower_negotiator_name,
    #:starter_negotiator_image_name,
    #:follower_negotiator_image_name,
    presence: true
=begin
  def self_update
    reload if persisted?
    messages.each do |message|
      message.self_update
    end
    self
  end
=end
end
