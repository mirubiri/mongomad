Fabricator(:product) do
  product_box
  thing_id { Fabricate(:thing)._id }
  name 'A product'
  description 'A product description'
end