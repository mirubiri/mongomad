Fabricator(:negotiation_conversation, class_name: 'Negotiation::Conversation') do
  transient         :user
  negotiation       nil
  messages(count:1) { |attrs| Fabricate.build(:negotiation_conversation_message, user:attrs[:user]) }
end
