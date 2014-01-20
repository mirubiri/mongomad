Fabricator(:offer) do
  user_composer { Fabricate(:user_with_items) }
  user_receiver { Fabricate(:user_with_items) }
  user_sheets   { |attrs| [ Fabricate.build(:user_sheet, user:attrs[:user_composer]), Fabricate.build(:user_sheet, user:attrs[:user_receiver]) ] }
  proposal      { |attrs| Fabricate.build(:proposal, composer:attrs[:user_composer], receiver:attrs[:user_receiver]) }
  message       { Faker::Lorem.sentence }
end
