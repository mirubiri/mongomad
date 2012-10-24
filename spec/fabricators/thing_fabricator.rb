Fabricator(:thing) do
  thing_box
  name 'cosa de prueba'
  description 'descripcion de prueba'
=begin
  after_build do |thing|
    thing.main_photo=Fabricate.build(:photo)
  end
=end
end