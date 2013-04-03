Fabricator(:deal_agreement_conversation, class_name: "Deal::Agreement::Conversation") do
  transient :conversation
  agreement nil
  messages do |attrs|
    messages = []
    attrs[:conversation].messages.each do |message|
      messages << Fabricate.build(:deal_agreement_conversation_message, message:message)
    end
    messages
  end
end
