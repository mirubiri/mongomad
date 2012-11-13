Fabricator(:receiver) do
  polymorphic_receiver { Fabricate.build(:offer,receiver:nil) }
  products(count:3) { Fabricate.build(:product,polymorphic_product:nil) }
  user_id 'an existing user_receiver_id'
end