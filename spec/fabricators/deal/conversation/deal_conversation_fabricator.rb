Fabricator(:deal_conversation, class_name: "Deal::Conversation") do
  transient         :signers
  deal              nil
  messages(count:1) { |attrs| Fabricate.build(:deal_conversation_message, user:attrs[:signers].first) }
  # starter_name        { |attrs| attrs[:signers].first.profile.nickname }
  # follower_name       { |attrs| attrs[:signers].last.profile.nickname }
  # starter_image_name  { |attrs| attrs[:signers].first.profile.image_name }
  # follower_image_name { |attrs| attrs[:signers].last.profile.image_name }
end
