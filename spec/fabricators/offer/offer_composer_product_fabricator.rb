Fabricator(:offer_composer_product, class_name: "Offer::Composer::Product") do
  transient   :thing
  composer    nil
  images      do |attrs|
    images = []
    attrs[:thing].images.each do |image|
      images << Fabricate.build(:offer_composer_product_image, file:image.file.url)
    end
    images
  end
  thing_id    { |attrs| attrs[:thing]._id }
  name        { |attrs| attrs[:thing].name }
  description { |attrs| attrs[:thing].description }
  quantity    1
  main_image  { |attrs| attrs[:thing].main_image }
end
