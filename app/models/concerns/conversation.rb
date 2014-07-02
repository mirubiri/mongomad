module Conversation
  extend ActiveSupport::Concern

  included do
    embeds_many :messages, as: :message_container
  end
end
