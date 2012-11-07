Fabricator(:composer) do
  #Relaciones
  polymorphic_composer
  #Atributos
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
  full_name 'full name'
end