Fabricator(:offer_money, class_name: "Offer::Money") do
  transient :user
  offer     nil
  user_id   { |a| a[:user]._id }
  quantity 25
end
