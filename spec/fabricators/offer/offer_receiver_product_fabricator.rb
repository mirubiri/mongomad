Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  transient       :thing

  receiver        nil
  images          nil

  thing_id        { |a| a[:thing]._id }
  main_image      { |a| a[:thing].main_image }
  name            { |a| a[:thing].name }
  description     { |a| a[:thing].description }
  quantity        1


  after_build do |product|
    user = User.where(:"things.thing_id" == product.thing_id)
    things = user.first.things.where(:_id == product.thing_id)
    images << things.first.images.each do |image|
      Fabricate.build(:offer_receiver_product_image,file:image.file.url)
    end
  end
end
