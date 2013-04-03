Fabricator(:user_thing, class_name: "User::Thing") do
  user        nil
  name        { Faker::Lorem.word }
  description { Faker::Lorem.sentence(word_count = 15) }
  stock       5
  image       { File.open('app/assets/images/car.png') }
  image_name  'car.png'

  after_build do |thing|
    thing.image.store!
  end
end

Fabricator(:user_medico_thing_mp3, from: "User::Thing") do
  name        'Mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  stock       4
  image       { File.open('app/assets/images/medico_mp3.jpg') }
  image_name  'medico_mp3.jpg'

  after_build do |thing|
    thing.image.store!
  end
end

Fabricator(:user_medico_thing_cartera, from: "User::Thing") do
  name        'Cartera'
  description 'Mi cartera llena de dineros no como la tuya que solo tiene polvo.'
  stock       1
  image       { File.open('app/assets/images/medico_cartera.jpg') }
  image_name  'medico_cartera.jpg'

  after_build do |thing|
    thing.image.store!
  end
end

Fabricator(:user_sergio_thing_mando, from: "User::Thing") do
  name        'Mando'
  description 'El mando de mi bicicleta mercedes.'
  stock       1
  image       { File.open('app/assets/images/sergio_mando.jpg') }
  image_name  'sergio_mando.jpg'

  after_build do |thing|
    thing.image.store!
  end
end

Fabricator(:user_sergio_thing_cartera, from: "User::Thing") do
  name        'Cartera'
  description 'Cartera de titanio reforzado para llevar gran cantidad de moneditas.'
  stock       1
  image       { File.open('app/assets/images/sergio_cartera.jpg') }
  image_name  'sergio_cartera.jpg'

  after_build do |thing|
    thing.image.store!
  end
end
