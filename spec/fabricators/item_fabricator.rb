Fabricator(:item) do
	user_id     { Faker::Number.number(3) }
  name        { Faker::Commerce.product_name.slice(0,20) }
  description { Faker::Lorem.sentence(rand(1..60)).slice(0,200) }
  images      { [ Fabricate.build(:image, main:true), Fabricate.build(:image) ] }
end
