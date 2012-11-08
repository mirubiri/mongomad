Fabricator(:receiver) do
  polymorphic_receiver { Fabricate.build(:offer) }
  user_id { Fabricate.build(:user)._id }
  
  after_build do |receiver|
    receiver.products << Fabricate.build(:product,polymorphic_product: receiver)
  end
end