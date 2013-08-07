# Fabricator(:negotiation_conversation_message, class_name: 'Negotiation::Conversation::Message') do
#   transient    :user
#   conversation nil
#   user_id      { |attrs| attrs[:user].id }
#   name         { |attrs| attrs[:user].name }
#   text         { Faker::Lorem.sentence }
# end
