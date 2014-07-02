Fabricator(:alert) do
  user     { Fabricate(:user) }
  text     { Faker::Lorem.sentence(rand(1..40)).slice(0,160) }
  location [ Faker::Number.number(3), Faker::Number.number(3) ]
end
