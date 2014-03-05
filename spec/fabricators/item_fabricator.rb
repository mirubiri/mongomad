Fabricator(:item) do
  user
  name        'Reproductor mp3'
  description 'Un reproductor mp3 acojonante de bueno.'
  images      { [ Fabricate.build(:image_product, main:true), Fabricate.build(:image_product), Fabricate.build(:image_product) ] }
end
