Fabricator(:composer) do
  polymorphic_composer { Fabricate.build(:offer,composer:nil) }
  products(count:3) { Fabricate.build(:product,polymorphic_product:nil) }
  composer_id 'an existing composer_id'
  composer_name 'composer name'
end