Fabricator(:cash) do
	user_id  { Faker::Number.number(3) }
  amount   '100€'
end
