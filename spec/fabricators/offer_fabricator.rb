Fabricator(:offer) do
  user_composer     { Fabricate(:user_with_items) } # PENDIENTE - Conseguir que los items se guarden con .build
  user_receiver   { Fabricate(:user_with_items) }
  proposal        { |attrs| Fabricate.build(:proposal,composer:attrs[:user_composer],receiver:attrs[:user_receiver]) }
  user_sheets     { |attrs| [ Fabricate.build(:user_sheet,user:attrs[:user_composer]), Fabricate.build(:user_sheet,user:attrs[:user_receiver]) ] }

  message { Faker::Lorem.sentence }
end