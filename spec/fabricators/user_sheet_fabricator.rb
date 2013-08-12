Fabricator(:user_sheet) do
  transient :container
  nick { Faker::Name.first_name }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }

  user_sheet_container do |attrs|
    Fabricate.build(:user,sheet:nil) if attrs[:container]==:user
  end
end
