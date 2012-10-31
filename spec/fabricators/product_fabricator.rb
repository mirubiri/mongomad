Fabricator(:product) do
  product_box
  thing_id { Fabricate(:thing)._id }
  name 'A product'
  description 'A product description'
  main_photo_url 'http://host/photo.jpg'
end