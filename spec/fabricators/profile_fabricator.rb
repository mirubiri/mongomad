Fabricator(:profile) do
  user       { Fabricate.build(:user, profile:nil) }
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  language   'english'
  location  [Faker::Number.number(3),Faker::Number.number(3)]
end

Fabricator(:user_medico_profile, from: :profile) do
  first_name 'Eduardo'
  last_name  'Hormilla'
  language   'spanish'
  location  [Faker::Number.number(3),Faker::Number.number(3)]
end

Fabricator(:user_sergio_profile, from: :profile) do
  first_name 'Sergio'
  last_name  'de Torre'
  language 'english'
  location  [Faker::Number.number(3),Faker::Number.number(3)]
end
