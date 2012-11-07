Fabricator(:money) do
  owner { Fabricate.build(:user)._id }
  quantity 3
end