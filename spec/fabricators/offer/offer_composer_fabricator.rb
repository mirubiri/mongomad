Fabricator(:offer_composer, class_name: "Offer::Composer") do
  offer nil
  products nil
  user_id 'user_id'
  name 'name'
  image { File.open('app/assets/images/rails.png') }
end