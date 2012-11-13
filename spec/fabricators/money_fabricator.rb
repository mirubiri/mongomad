Fabricator(:money) do
  polymorphic_money { Fabricate.build(:offer) }
  owner_id 'an exiting user_owner_id'
  quantity 100
end