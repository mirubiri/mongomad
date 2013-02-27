Fabricator(:offer) do
  user_composer   { Fabricate(:user_with_things) }
  user_receiver   { Fabricate(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:user_composer]) }
  receiver        { |attrs| Fabricate.build(:offer_receiver, user:attrs[:user_receiver]) }
  money           { Fabricate.build(:offer_money) }
  initial_message "this is offer's initial message. it is the first contact between both users. it has to be long enough to try the interface"
end
