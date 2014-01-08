Fabricator(:offer) do
  #TODO: PENDIENTE - Conseguir que los items se guarden con .build
  user_composer { Fabricate(:user_with_items) } 
  user_receiver { Fabricate(:user_with_items) }
  proposal      { |attrs| Fabricate.build(:proposal, composer:attrs[:user_composer], receiver:attrs[:user_receiver]) }
  message       { Faker::Lorem.sentence }
end