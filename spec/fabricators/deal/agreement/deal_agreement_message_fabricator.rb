Fabricator(:deal_agreement_message, class_name: "Deal::Agreement::Message") do
  agreement nil
  user_id 'user_id'
  user_name 'user name'
  text 'text'
  image { File.open('app/assets/images/rails.png') }
end