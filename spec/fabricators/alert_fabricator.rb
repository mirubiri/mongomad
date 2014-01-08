Fabricator(:alert) do
  user     { Fabricate(:user) }
  text     { Faker::Lorem.sentence }
  location [ Faker::Number.number(3), Faker::Number.number(3) ]
end
