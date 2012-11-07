Fabricator(:receiver) do
  #Relaciones
  polymorphic_receiver
  #Atributos
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
end