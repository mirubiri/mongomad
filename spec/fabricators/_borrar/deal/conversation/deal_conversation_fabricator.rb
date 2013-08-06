Fabricator(:deal_conversation, class_name: 'Deal::Conversation') do
  transient         :user
  deal              nil
  messages(count:1) { |attrs| Fabricate.build(:deal_conversation_message, user:attrs[:user]) }
end
