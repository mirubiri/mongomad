Fabricator(:offer_composer_product_image, class_name: "Offer::Composer::Product::Image") do
  product  nil
  file     nil #no es necesario darle un valor ya que se rellena en el producto
end
