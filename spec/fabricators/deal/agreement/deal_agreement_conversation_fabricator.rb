Fabricator(:deal_agreement_message, class_name: "Deal::Agreement::Message") do
  transient :message
  agreement nil
  user_name { |attrs| attrs[:message].user_name }
  text      'this is an old negotiation\'s message. it was written by one of the users when they were negotiating.'
  image     { |attrs| File.open(attrs[:message].image.path) }
end
