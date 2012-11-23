Fabricator(:composer) do
  composer_parent { Fabricate.build(:offer,composer:nil) }
  products(count:1) { Fabricate.build(:product,product_parent:nil) }
  user_id 'an existing user_id'
  name 'composer name'
  image { File.open('app/assets/images/rails.png') }
end