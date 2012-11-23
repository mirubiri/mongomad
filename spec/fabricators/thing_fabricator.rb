Fabricator(:thing) do
  user { Fabricate.build(:user,things:nil) }
  name 'name'
  description 'description'
  stock 5
  main_image { File.open('app/assets/images/rails.png') }
end