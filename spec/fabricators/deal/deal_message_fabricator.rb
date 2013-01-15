Fabricator(:deal_message, class_name: "Deal::Message") do
  transient :negotiation
  deal      nil
  user_id   { |attrs| attrs[:negotiation].proposals.last.composer.user_id }
  user_name { |attrs| attrs[:negotiation].proposals.last.composer.name }
  text      'this is the first deal\'s message. it\'s written by the users when they close a deal.'
  image     { |attrs| File.open(attrs[:negotiation].proposals.last.composer.image) }
end
