Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  transient   :thing
  receiver    nil

  images      do |a|
    a[:thing].images.each do |image|
      Fabricate.build(:offer_composer_product_image, file:image.file.url)
    end
  end

  thing_id    { |a| a[:thing]._id }
  main_image  { |a| a[:thing].main_image }
  name        { |a| a[:thing].name }
  description { |a| a[:thing].description }
  quantity    1
end
