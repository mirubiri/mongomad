Fabricator(:negotiation_conversation, class_name: 'Negotiation::Conversation') do
  transient         :negotiators
  negotiation       nil
  messages(count:1) { |attrs| Fabricate.build(:negotiation_conversation_message, user:attrs[:negotiators].first) }
end
