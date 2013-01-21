Fabricator(:offer) do
  users(count: 2) { Fabricate(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].first) }
  receiver        { |attrs| Fabricate.build(:offer_receiver, user:attrs[:users].last) }
  money           { Fabricate.build(:offer_money) }
  initial_message 'this is offer\'s initial message. it is the first contact between both users. it has to be long enough to try the interface.'
end
