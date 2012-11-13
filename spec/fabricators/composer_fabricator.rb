Fabricator(:composer) do
  polymorphic_composer { Fabricate.build(:offer,composer:nil)}
  user_id 'user_composer_id'
  full_name "Nombre"
  products(count:3) { Fabricate.build(:product,polymorphic_product:nil) }
end