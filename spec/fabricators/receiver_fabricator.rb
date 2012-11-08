Fabricator(:receiver) do
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
  
  after_build do |receiver|
    receiver.products << Fabricate.build(:product,offer:offer)
  end
end