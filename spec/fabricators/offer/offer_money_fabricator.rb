Fabricator(:offer_money, class_name: "Offer::Money") do
  offer    { Fabricate.build(:offer, offer_money:nil) }
  user_id  nil
  quantity 25

  after_build do |money|
    user = Fabricate.build(:user)
    money.user_id ||= user._id
  end
end
