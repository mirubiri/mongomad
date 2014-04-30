Fabricator(:message) do
  user_id           { Faker::Number.number(3) }
  text              { Faker::Lorem.sentence(rand(1..120)).slice(0,400) }
end
