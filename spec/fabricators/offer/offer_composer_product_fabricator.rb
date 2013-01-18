Fabricator(:offer_composer_product, class_name: "Offer::Composer::Product") do
  transient   :thing
  composer    nil
  thing_id    { |attrs| attrs[:thing]._id }
  name        { |attrs| attrs[:thing].name }
  description { |attrs| attrs[:thing].description }
  quantity    1
  image  { |attrs| attrs[:thing].image }
end
