Fabricator(:offer_composer_product, class_name: 'Offer::Composer::Product') do
  transient   :thing
  composer    nil
  thing_id    { |attrs| attrs[:thing].id }
  name        { |attrs| attrs[:thing].name }
  description { |attrs| attrs[:thing].description }
  quantity    1
end
