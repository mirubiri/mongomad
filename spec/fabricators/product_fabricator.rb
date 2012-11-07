Fabricator(:product) do
  thing_id { Fabricate.build(:thing)._id }
  name 'name'
  description 'description'
  quantity 5
end