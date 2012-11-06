Fabricator(:product) do
  thing_id { Fabricate.build(:thing)._id }
  name 'un nombre'
  description 'una descripcion'
  quantity 1
end