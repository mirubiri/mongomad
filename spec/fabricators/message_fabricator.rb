Fabricator(:message) do
  user_id           { Faker::Code.isbn }
  text              { Faker::Lorem.sentence(rand(1..120)).slice(0,400) }
end
