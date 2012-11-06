Fabricator(:receiver) do
  products { [Fabricate.build(:product)] }
  user_id { Fabricate.build(:user)._id }
end