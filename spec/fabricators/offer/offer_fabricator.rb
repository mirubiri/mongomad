Fabricator(:offer) do
  user_composer   { Fabricate(:user_with_things) }
  user_receiver   { Fabricate(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:user_composer]) }
  receiver        { |attrs| Fabricate.build(:offer_receiver, user:attrs[:user_receiver]) }
  money           { Fabricate.build(:offer_money) }
  initial_message { Faker::Lorem.sentence(word_count = 10) }
end

Fabricator(:offer_improcex, from: :offer) do
  user_composer { Fabricate(:user_medico) }
  user_receiver { Fabricate(:user_sergio) }
end
