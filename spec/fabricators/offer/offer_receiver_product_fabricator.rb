Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  transient   :thing
  receiver    nil
  thing_id    { |attrs| attrs[:thing]._id }
  name        { |attrs| attrs[:thing].name }
  description { |attrs| attrs[:thing].description }
  quantity    1
  image_url   { |attrs| attrs[:thing].image_url }
end
