Fabricator(:user_thing, class_name: 'User::Thing') do
  user        nil
  name        { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
  stock       2
  image       ActionDispatch::Http::UploadedFile.new({
    :filename     => 'car.png',
    :content_type => 'image/png',
    :tempfile     => File.new('app/assets/images/car.png')})
end

Fabricator(:user_medico_thing_mp3, from: 'User::Thing') do
  user        nil
  name        'Mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  stock       1000
  image       ActionDispatch::Http::UploadedFile.new({
    :filename     => 'medico_mp3.jpg',
    :content_type => 'image/jpg',
    :tempfile     => File.new('app/assets/images/medico_mp3.jpg')})
end

Fabricator(:user_medico_thing_cartera, from: 'User::Thing') do
  user        nil
  name        'Cartera'
  description 'Mi cartera llena de dineros no como la tuya que solo tiene polvo.'
  stock       1000
  image       ActionDispatch::Http::UploadedFile.new({
    :filename     => 'medico_cartera.jpg',
    :content_type => 'image/jpg',
    :tempfile     => File.new('app/assets/images/medico_cartera.jpg')})
end

Fabricator(:user_sergio_thing_mando, from: 'User::Thing') do
  user        nil
  name        'Mando'
  description 'El mando de mi bicicleta mercedes.'
  stock       1000
  image       ActionDispatch::Http::UploadedFile.new({
    :filename     => 'sergio_mando.jpg',
    :content_type => 'image/jpg',
    :tempfile     => File.new('app/assets/images/sergio_mando.jpg')})
end

Fabricator(:user_sergio_thing_cartera, from: 'User::Thing') do
  user        nil
  name        'Cartera'
  description 'Cartera de titanio reforzado para llevar gran cantidad de moneditas.'
  stock       1000
  image       ActionDispatch::Http::UploadedFile.new({
    :filename     => 'sergio_cartera.jpg',
    :content_type => 'image/jpg',
    :tempfile     => File.new('app/assets/images/sergio_cartera.jpg')})
end
