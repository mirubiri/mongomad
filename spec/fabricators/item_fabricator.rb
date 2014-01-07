Fabricator(:item) do
  user
  name        'Mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  stock       5
  images      { [ Fabricate.build(:image_product, main:true) ] }
end
