Fabricator(:user_profile, class_name: 'User::Profile') do
  user nil
  name {Faker::Name.first_name}
  surname {Faker::Name.last_name}
  nickname {Faker::Internet.user_name }
  sex 'men'
  country {Faker::Address.country}
  birth_date '10-10-2000'
  website nil
  delivery_address nil
  phone_number nil
  image {Fabricate.build(:image,polymorphic_image:nil)}
end