Fabricator(:receiver) do
  #Relaciones
  polymorphic_receiver
  after_build do |receiver|
    receiver.products << Fabricate.build(:polymorphic_product,offer:offer)
  end
  #Atributos
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
end