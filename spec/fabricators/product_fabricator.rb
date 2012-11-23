Fabricator(:product) do
  product_parent { Fabricate.build(:composer, products:nil) }
  thing_id 'an existing thing_id'
  name 'name'
  description 'description'
  quantity 5
  main_image { File.open('app/assets/images/rails.png') }
end