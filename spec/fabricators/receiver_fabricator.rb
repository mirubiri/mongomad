Fabricator(:receiver) do
  polymorphic_receiver { Fabricate.build(:offer,receiver:nil) }
  products(count:3) { Fabricate.build(:product,polymorphic_product:nil) }
  receiver_id 'an existing receiver_id'
  receiver_name 'receiver name'
end