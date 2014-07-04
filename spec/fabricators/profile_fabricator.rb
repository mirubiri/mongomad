Fabricator(:profile) do
  full_name { Faker::Name.name }
  gender     'male'
  language   'english'
  birth_date '05/08/1958'
  location   [ Faker::Address.latitude, Faker::Address.longitude ]
  images     { [ Fabricate.build(:image,main: true) ] }
end
