Fabricator(:user_thing, class_name: "User::Thing") do
  user        nil
  name        { Faker::Lorem.word }
  description { Faker::Lorem.sentence(word_count = 15) }
  stock       5
  image       { File.open('app/assets/images/monkey.png') }
  image_name  'monkey.png'

  after_build do |thing|
    thing.image.store!
  end
end
