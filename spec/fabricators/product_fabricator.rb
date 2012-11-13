Fabricator(:product) do
  polymorphic_product { Fabricate.build(:composer,products:nil,polymorphic_composer:nil) }
  thing_id 'an existing thing_id'
  name 'name'
  description 'description'
  quantity 5
end