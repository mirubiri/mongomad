Fabricator(:offer_receiver_product_image, class_name: "Offer::Receiver::Product::Image") do
  product nil
  file    { File.open('app/assets/images/rails.png') }
end