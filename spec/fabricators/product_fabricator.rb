Fabricator(:product) do
  #Relaciones
  polymorphic_product
  #Atributos
  thing_id { Fabricate.build(:thing)._id }
  name 'name'
  description 'description'
  quantity 5
end