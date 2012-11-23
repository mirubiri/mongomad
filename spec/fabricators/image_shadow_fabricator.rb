Fabricator(:image_shadow) do
  image_shadow_parent { Fabricate.build(:product,main_image:nil) }
  file { File.open('app/assets/images/rails.png') }
end
