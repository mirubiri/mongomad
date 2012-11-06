Fabricator(:money) do
  owner { Fabricate.build(:user)._id }
  quantity 0.3
end