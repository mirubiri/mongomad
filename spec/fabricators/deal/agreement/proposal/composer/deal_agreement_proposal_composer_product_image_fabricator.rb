Fabricator(:image) do
  polymorphic_image { Fabricate.build(:product,main_image:nil) }
  file { File.open('app/assets/images/rails.png') }
end
