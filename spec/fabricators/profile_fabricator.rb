Fabricator(:profile) do
  first_name { Faker::Name.first_name.slice(0,15) }
  last_name  { Faker::Name.last_name.slice(0,15) }
  gender     'male'
  language   'english'
  birth_date '05/08/1958'
  location   [ Faker::Address.latitude, Faker::Address.longitude ]
  images     { [ Fabricate.build(:image_face) ] }
end
