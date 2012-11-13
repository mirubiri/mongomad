Fabricator(:receiver) do
  polymorphic_receiver { Fabricate.build(:offer,receiver:nil)}
  user_id 'user_receiver_id'
  products(count:3) { Fabricate.build(:product,polymorphic_product:nil) }
end