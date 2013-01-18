Fabricator(:deal_message, class_name: "Deal::Message") do
  transient :message
  deal      nil
  user_id   { |attrs| attrs[:message].user_id }
  user_name { |attrs| attrs[:message].user_name }
  text      'this is the first deal\'s message. it\'s written by the users when they close a deal.'
  image     { File.open('app/assets/images/message.png') }
end
