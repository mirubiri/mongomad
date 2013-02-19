Fabricator(:negotiation_conversation, class_name: "Negotiation::Conversation") do
  transient   :offer
  negotiation nil
  messages(count: 1) { |attrs| Fabricate.build(:negotiation_conversation_message, composer:attrs[:offer].composer)            }
end
