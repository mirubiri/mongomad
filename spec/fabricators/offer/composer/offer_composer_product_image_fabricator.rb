Fabricator(:offer_composer_product_image, class_name: "Offer::Composer::Product::Image") do
  product nil
  file { File.open('app/assets/images/rails.png') }
end
