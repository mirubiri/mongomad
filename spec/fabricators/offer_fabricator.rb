Fabricator(:offer) do
  user_sender     { Fabricate.build(:user) }
  user_receiver   { Fabricate.build(:user) }
  proposal        { Fabricate.build(:proposal) }
  user_sheets do |attrs|
    [attrs[:user_sender].sheet,attrs[:user_receiver].sheet]
  end

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
