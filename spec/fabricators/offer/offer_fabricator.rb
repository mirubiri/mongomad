Fabricator(:offer) do
  users(count: 2) { Fabricate.build(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].first) }
  receiver        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].last) }
  money           nil
  initial_message 'this is offer\'s initial message. it is the first contact between both users. it has to be long enough to try the interface.'
end
