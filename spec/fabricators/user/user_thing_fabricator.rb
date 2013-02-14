Fabricator(:user_thing, class_name: "User::Thing") do
  user        nil
  name        'name'
  description 'thing description'
  stock       5
  image       { File.open('app/assets/images/car.png') }
  image_name  'car.png'

  after_build do |thing|
    thing.image.store!
  end
end
