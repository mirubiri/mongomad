Fabricator(:thing) do
  user { Fabricate.build(:user,things:nil) }
  name 'name'
  description 'description'
  stock 5
  main_image { Fabricate.build(:image,polymorphic_image:nil) }
end