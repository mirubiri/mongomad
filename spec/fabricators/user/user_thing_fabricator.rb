Fabricator(:user_thing, class_name: "User::Thing") do
  user        nil
  name        'name'
  description { Faker::Lorem.sentence(word_count=10) }
  stock       5
  image       { File.open('app/assets/images/car.png') }
  image_name  'car.png'

  after_build do |thing|
    thing.image.store!
  end
end
