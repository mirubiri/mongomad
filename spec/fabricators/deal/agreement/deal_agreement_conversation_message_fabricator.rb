Fabricator(:deal_agreement_conversation_message, class_name: 'Deal::Agreement::Conversation::Message') do
  transient         :message
  conversation      nil
  user_id           { |attrs| attrs[:message].user_id }
  name              { |attrs| attrs[:message].name }
  text              { |attrs| attrs[:message].text }
  image_fingerprint { |attrs| attrs[:message].image_fingerprint }
end
