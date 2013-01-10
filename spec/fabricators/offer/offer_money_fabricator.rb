Fabricator(:offer_money, class_name: "Offer::Money") do
  transient :user
  offer     nil
  user_id   { |attrs| attrs[:user]._id }
  quantity 2500
end
