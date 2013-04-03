Fabricator(:user_thing, class_name: "User::Thing") do
  user        nil
  name        { Faker::Lorem.word }
  description { Faker::Lorem.sentence(word_count = 15) }
  stock       5
  image       { File.open('app/assets/images/house.png') }
  image_name  'house.png'

  after_build do |thing|
    thing.image.store!
  end
end
