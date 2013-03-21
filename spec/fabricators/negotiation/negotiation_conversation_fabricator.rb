Fabricator(:negotiation_conversation, class_name: "Negotiation::Conversation") do
  transient        :negotiators
  negotiation nil
  messages(count:1) { |attrs| Fabricate.build(:negotiation_conversation_message, user:attrs[:negotiators].first) }
  starter_negotiator_name  { |attrs| attrs[:negotiators].first.profile.nickname }
  follower_negotiator_name{ |attrs| attrs[:negotiators].last.profile.nickname }
  #starter_negotiator_image_name { |attrs| attrs[:negotiators].first.profile.image_name }
  #follower_negotiator_image_name { |attrs| attrs[:negotiators].last.profile.image_name }
end
