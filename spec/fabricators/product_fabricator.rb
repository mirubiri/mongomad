Fabricator(:product) do
  id          { Faker::Code.isbn }
  user_id     { Faker::Code.isbn }
  name        { Faker::Commerce.product_name.slice(0,20) }
  description { Faker::Lorem.sentence(rand(1..60)).slice(0,200) }
  images      { [ Fabricate.build(:image, main:true), Fabricate.build(:image) ] }
end