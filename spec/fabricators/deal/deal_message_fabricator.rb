Fabricator(:deal_message, class_name: "Deal::Message") do
  transient :message
  deal      nil
  user_name { |attrs| attrs[:message].user_name }
  text      'this is the first deal\'s message. it\'s written by the users when they close a deal.'
  image     { |attrs| File.open(attrs[:message].image.path) }
end
