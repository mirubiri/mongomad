Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  transient       :thing
  receiver        { Fabricate.build(:offer_receiver, products:nil, user:Fabricate(:user),user_composer:Fabricate(:user)) }
  images(count:1) { Fabricate.build(:offer_receiver_product_image, product:nil) }
  thing_id        { |a| a[:thing]._id }
  name            { |a| a[:thing].name }
  description     { |a| a[:thing].description }
  quantity        1
  main_image      { |a| a[:thing].try{ |thing| thing.images.last.file.url } }
  
  after_build do |product|
    product.receiver.try { |receiver| receiver.products << product }
  end
end
