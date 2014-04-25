Fabricator(:cash) do
	user_id  { Faker::Number.number(3) }
  money    { Money.new(rand(1..5000)) }
  images   { [ Fabricate.build(:image_money) ] }
end
