Fabricator(:offer_receiver_product_image, class_name: "Offer::Receiver::Product::Image") do
  product  { Fabricate.build(:offer_receiver_product, images:nil) }
  file    'file_path'
end
