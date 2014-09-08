Fabricator(:cash) do
	user_id  { Faker::Code.isbn }
  amount   '100€'
end
