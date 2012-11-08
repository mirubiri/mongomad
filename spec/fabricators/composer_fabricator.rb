Fabricator(:composer) do
  #Relaciones
  polymorphic_composer
  after_build do |composer|
    composer.products << Fabricate.build(:polymorphic_product,offer:offer)
  end
  #Atributos
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
  full_name 'full name'
end