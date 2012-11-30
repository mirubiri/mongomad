Fabricator(:deal_message, class_name: "Deal::Message") do
  deal      nil
  user_id   'user_id'
  user_name 'user name'
  text      'text'
  image     { File.open('app/assets/images/rails.png') }
end