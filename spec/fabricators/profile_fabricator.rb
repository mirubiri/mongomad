Fabricator(:profile) do
  user       { Fabricate.build(:user, profile:nil) }
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  gender     'male'
  language   'english'
  birth_date '05/08/1958'
  location   [ Faker::Address.latitude, Faker::Address.longitude ]
  images     { [ Fabricate.build(:image_face) ] }
end
