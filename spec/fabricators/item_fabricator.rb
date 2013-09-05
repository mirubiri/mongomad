Fabricator(:item) do
  user        { Fabricate.build(:user) }
  name        'Mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  stock       5
end

# Fabricator(:user_medico_thing_mp3, from: 'User::Thing') do
#   user        nil
#   name        'Mp3'
#   description 'Un reproductor mp3 acojonante de bueno.'
#   stock       1000
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'medico_mp3.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/medico_mp3.jpg')})
# end

# Fabricator(:user_medico_thing_cartera, from: 'User::Thing') do
#   user        nil
#   name        'Cartera'
#   description 'Mi cartera llena de dineros no como la tuya que solo tiene polvo.'
#   stock       1000
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'medico_cartera.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/medico_cartera.jpg')})
# end

# Fabricator(:user_sergio_thing_mando, from: 'User::Thing') do
#   user        nil
#   name        'Mando'
#   description 'El mando de mi bicicleta mercedes.'
#   stock       1000
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'sergio_mando.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/sergio_mando.jpg')})
# end

# Fabricator(:user_sergio_thing_cartera, from: 'User::Thing') do
#   user        nil
#   name        'Cartera'
#   description 'Cartera de titanio reforzado para llevar gran cantidad de moneditas.'
#   stock       1000
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'sergio_cartera.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/sergio_cartera.jpg')})
# end

# Fabricator(:user_sofia_thing_perro, from: 'User::Thing') do
#   user        nil
#   name        'Perro'
#   description 'Mi perro que hace guau guau.'
#   stock       1000
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'sofia_perro.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/sofia_perro.jpg')})
# end

# Fabricator(:user_sofia_thing_choza, from: 'User::Thing') do
#   user        nil
#   name        'Choza'
#   description 'Choza veraniega ideal para pasar las vacaciones en plan tribal.'
#   stock       1000
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'sofia_choza.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/sofia_choza.jpg')})
# end
