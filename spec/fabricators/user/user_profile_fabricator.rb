Fabricator(:user_profile, class_name: "User::Profile") do
  user             { Fabricate.build(:user, profile:nil) }
  name             { Faker::Name.first_name }
  surname          { Faker::Name.last_name }
  nickname         { Faker::Internet.user_name }
  sex              'man'
  country          { Faker::Address.country }
  delivery_address nil
  phone_number     nil
  website          nil
  birth_date       '10-10-2000'
  image            { File.open('app/assets/images/rails.png') }
end
