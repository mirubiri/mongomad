Fabricator(:user_thing, class_name: "User::Thing") do
  user        nil
  name        'name'
  description 'this is thing\'s description. my thing is the most beautiful you have ever seen! if you need it, make and offer and it\'s yours!'
  stock       5
  image       { File.open('app/assets/images/car.png') }
  image_name  'car.png'

  after_build do |thing|
    thing.image.store!
  end
end
