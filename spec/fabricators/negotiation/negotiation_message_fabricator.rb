Fabricator(:negotiation_message, class_name: "Negotiation::Message") do
  negotiation nil
  user_id     'user_id'
  user_name   'user name'
  text        'text'
  image       'app/assets/images/rails.png'
end
