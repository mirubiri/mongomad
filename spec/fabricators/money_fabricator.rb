Fabricator(:money) do
  polymorphic_money { Fabricate.build(:offer) }
  owner 'owner_id'
  quantity 100
end