Fabricator(:item) do
  user
  name        { Faker::Name.first_name }
  description { Faker::Lorem.sentence }
  images      { [ Fabricate.build(:image_product, main:true), Fabricate.build(:image_product) ] }
end
