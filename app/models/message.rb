class Message
  include Mongoid::Document
  embedded_in :conversation
end
