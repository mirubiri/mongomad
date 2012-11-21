Fabricator(:composer) do
  polymorphic_composer { Fabricate.build(:offer,composer:nil) }
  products(count:1) { Fabricate.build(:product,polymorphic_product:nil) }
  user_id 'an existing user_id'
  name 'composer name'
  photo {Fabricate.build(:image,polymorphic_image:nil)}
end