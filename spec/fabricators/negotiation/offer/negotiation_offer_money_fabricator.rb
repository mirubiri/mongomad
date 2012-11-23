Fabricator(:money) do
  polymorphic_money { Fabricate.build(:offer) }
  user_id 'an exiting user_id'
  quantity 100
end