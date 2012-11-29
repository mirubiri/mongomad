Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  receiver nil
  thing_id 'thing_id'
  name 'name'
  description 'description'
  quantity 5
  main_image { File.open('app/assets/images/rails.png') }
end