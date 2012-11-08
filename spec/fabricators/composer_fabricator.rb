Fabricator(:composer) do
  polymorphic_composer { Fabricate.build(:offer) }
  user_id { Fabricate.build(:user)._id }
  full_name 'full name'

  after_build do |composer|
    composer.products << Fabricate.build(:product,polymorphic_product: composer)
  end
end