Fabricator(:money) do
  #Relaciones
  polymorphic_money
  #Atributos
  owner { Fabricate.build(:user)._id }
  quantity 100
end