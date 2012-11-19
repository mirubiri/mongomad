Fabricator(:product) do
  polymorphic_product { Fabricate.build(:composer, products:nil) }
  thing_id 'an existing thing_id'
  name 'name'
  description 'description'
  quantity 5
  main_image { Fabricate.build(:image,polymorphic_image:nil) }
end