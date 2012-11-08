Fabricator(:money) do
  polymorphic_money { Fabricate(:offer) }
  owner { Fabricate.build(:user)._id }
  quantity 100
end