Fabricator(:profile) do
  user       { Fabricate.build(:user, profile:nil) }
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  language   'english'
  birth_date { Faker::Number.number(8) }
  location   [ Faker::Number.number(3), Faker::Number.number(3) ]
  images     { [ Fabricate.build(:image_face) ] }
end
