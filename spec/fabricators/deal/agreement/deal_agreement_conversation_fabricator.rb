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
  # starter_name        { |attrs| attrs[:conversation].starter_name }
  # follower_name       { |attrs| attrs[:conversation].follower_name }
  # starter_image_name  { |attrs| attrs[:conversation].starter_image_name }
  # follower_image_name { |attrs| attrs[:conversation].follower_image_name }
end
