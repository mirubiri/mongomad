Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  offer nil
  products nil
  user_id 'user_id'
  name 'name'
  image { File.open('app/assets/images/rails.png') }
end