Fabricator(:profile) do
  user { Fabricate.build(:user,profile:nil) }
  name {Faker::Name.first_name}
  surname {Faker::Name.last_name}
  nickname {Faker::Internet.user_name }
  sex 'men'
  country {Faker::Address.country}
  birth_date '10-10-2000'
  website {Faker::Internet.domain_name}
  photo {Fabricate.build(:image,polymorphic_image:nil)}
end