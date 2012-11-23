Fabricator(:receiver) do
  receiver_parent { Fabricate.build(:offer,receiver:nil) }
  products(count:1) { Fabricate.build(:product,product_parent:nil) }
  user_id 'an existing user_id'
  name 'receiver name'
  photo {Fabricate.build(:image,image_parent:nil)}
end