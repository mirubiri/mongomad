Fabricator(:negotiation_conversation, class_name: "Negotiation::Conversation") do
  negotiation nil
  messages(count:1) { Fabricate.build(:negotiation_conversation_message) }
end
