Fabricator(:item) do
  user
  name        'Mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  stock       5
end

Fabricator(:user_medico_item_mp3, from: :item) do
  name        'Mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  stock       100
end

Fabricator(:user_medico_item_cartera, from: :item) do
  name        'Cartera'
  description 'Mi cartera llena de dineros no como la tuya que solo tiene polvo.'
  stock       100
end

Fabricator(:user_sergio_item_mando, from: :item) do
  name        'Mando'
  description 'El mando de mi bicicleta mercedes.'
  stock       100
end

Fabricator(:user_sergio_item_cartera, from: :item) do
  name        'Cartera'
  description 'Cartera de titanio reforzado para llevar gran cantidad de moneditas.'
  stock       100
end
