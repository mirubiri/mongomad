Fabricator(:offer) do
  user_composer   { Fabricate(:user_with_things) }
  user_receiver   { Fabricate(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:user_composer]) }
  receiver        { |attrs| Fabricate.build(:offer_receiver, user:attrs[:user_receiver]) }
  money           { Fabricate.build(:offer_money) }
  initial_message { Faker::Lorem.sentence }
end

Fabricator(:offer_improcex, from: :offer) do
  user_composer { Fabricate(:user_medico) }
  user_receiver { Fabricate(:user_sergio) }
end

Fabricator(:offer_composer_money, from: :offer) do
  money { |attrs| Fabricate.build(:offer_money, user_id:attrs[:user_composer].id, quantity:100) }
end

Fabricator(:offer_receiver_money, from: :offer) do
  money { |attrs| Fabricate.build(:offer_money, user_id:attrs[:user_receiver].id, quantity:200) }
end
