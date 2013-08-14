Fabricator(:offer) do
  sender   { Fabricate.build(:user) }
  receiver   { Fabricate.build(:user) }
  proposal { Fabricate.build(:proposal, container: :offer) }
  sender_sheet do |attrs|
    Fabricate.build(:user_sheet, container: :offer) if attrs[:container] == :offer
    Fabricate.build(:user_sheet, container: :negotiation) if attrs[:container] == :negotiation
    Fabricate.build(:user_sheet, container: :deal) if attrs[:container] == :deal
  end
  receiver_sheet do |attrs|
    Fabricate.build(:user_sheet, container: :offer) if attrs[:container] == :offer
    Fabricate.build(:user_sheet, container: :negotiation) if attrs[:container] == :negotiation
    Fabricate.build(:user_sheet, container: :deal) if attrs[:container] == :deal
  end
  message



  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:user_composer]) }
  receiver        { |attrs| Fabricate.build(:offer_receiver, user:attrs[:user_receiver]) }
  money           { Fabricate.build(:offer_money) }
  initial_message { Faker::Lorem.sentence }
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
