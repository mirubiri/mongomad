Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  transient   :thing
  receiver    nil
  images      do |attrs|
    attrs[:thing].images.each do |image|
      Fabricate.build(:offer_composer_product_image, file:image.file.url)
    end
  end
  thing_id    { |attrs| attrs[:thing]._id }
  main_image  { |attrs| attrs[:thing].main_image }
  name        { |attrs| attrs[:thing].name }
  description { |attrs| attrs[:thing].description }
  quantity    1
end
