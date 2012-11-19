Fabricator(:image) do
  polymorphic_image { Fabricate.build(:thing,main_image:nil)}
  file File.open('app/assets/images/rails.png')
end
