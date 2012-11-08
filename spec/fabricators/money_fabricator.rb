Fabricator(:money) do
  #Relations
  polymorphic_money
  #Attributes
  owner { Fabricate.build(:user)._id }
  quantity 100
end