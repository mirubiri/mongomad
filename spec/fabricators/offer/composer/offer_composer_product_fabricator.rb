Fabricator(:offer_composer_product, class_name: "Offer::Composer::Product") do
  composer nil
  thing_id 'thing_id'
  name 'name'
  description 'description'
  quantity 5
  main_image nil
end