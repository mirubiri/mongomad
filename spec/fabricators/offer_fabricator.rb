Fabricator(:offer) do
  user_sender     { Fabricate(:user_with_items) }
  user_receiver   { Fabricate(:user_with_items) }
  proposal        { |attrs| Fabricate.build(:proposal,sender:attrs[:user_sender],receiver:attrs[:user_receiver]) }
  user_sheets     { |attrs| [ Fabricate.build(:user_sheet,user:attrs[:user_sender]), Fabricate.build(:user_sheet,user:attrs[:user_sender]) ] }

  message { Faker::Lorem.sentence }
end

# Fabricator(:offer_composer_money, from: :offer) do
#   money { |attrs| Fabricate.build(:offer_money, user_id:attrs[:user_composer].id, quantity:100) }
# end

# Fabricator(:offer_receiver_money, from: :offer) do
#   money { |attrs| Fabricate.build(:offer_money, user_id:attrs[:user_receiver].id, quantity:200) }
# end

# Fabricator(:offer_medico_sergio, from: :offer) do
#   user_composer { Fabricate(:user_medico) }
#   user_receiver { Fabricate(:user_sergio) }
# end

# Fabricator(:offer_sergio_sofia, from: :offer) do
#   user_composer { Fabricate(:user_sergio) }
#   user_receiver { Fabricate(:user_sofia) }
# end

# Fabricator(:offer_sofia_medico, from: :offer) do
#   user_composer { Fabricate(:user_sofia) }
#   user_receiver { Fabricate(:user_medico) }
# end
