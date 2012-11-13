Fabricator(:composer) do
  polymorphic_composer { Fabricate.build(:offer,composer:nil) }
  products(count:3) { Fabricate.build(:product,polymorphic_product:nil) }
  user_id 'an existing user_composer_id'
  full_name "full name"
end