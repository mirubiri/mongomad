Fabricator(:image) do
  image_parent { Fabricate.build(:product,main_image:nil) }
  file { File.open('app/assets/images/rails.png') }
end
