Fabricator(:offer_composer_product, class_name: "Offer::Composer::Product") do
  transient       :thing
  composer        { Fabricate.build(:offer_composer, products:nil) }
  images(count:1) { Fabricate.build(:offer_composer_product_image, product:nil) }
  thing_id        { |a| a[:thing]._id }
  name            { |a| a[:thing].name }
  description     { |a| a[:thing].description }
  quantity        1
  main_image      { |a| a[:thing].try { |thing| thing.images.last.file.url } }
  
  after_build do |product|
    product.composer.try { |composer| composer.products << product }
  end
end
