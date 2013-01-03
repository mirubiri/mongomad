Fabricator(:offer_money, class_name: "Offer::Money") do
  offer    { Fabricate.build(:offer, offer_money:nil) }
  user_id  'user_id'
  quantity 100
end
