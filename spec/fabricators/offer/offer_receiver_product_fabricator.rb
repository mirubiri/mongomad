Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  receiver        { Fabricate.build(:offer_receiver, products:nil)}
  images(count:1) { Fabricate.build(:offer_receiver_product_image, product:nil) }
  thing_id        nil
  name            nil
  description     nil
  quantity        1
  main_image      { |attrs| attrs[:images] &&
                            attrs[:images].last.file.url }

  after_build do |product|
    thing = Fabricate.build(:user_thing)
    product.thing_id ||= thing._id
    product.name ||= thing.name
    product.description ||= thing.description
  end
end
