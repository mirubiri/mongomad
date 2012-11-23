Fabricator(:money) do
  money_parent { Fabricate.build(:offer) }
  user_id 'an exiting user_id'
  quantity 100
end