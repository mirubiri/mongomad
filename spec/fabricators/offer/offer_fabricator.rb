Fabricator(:offer) do
  users(count: 2) { Fabricate.build(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].first) }
  receiver        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].last) }
  money           nil
  initial_message 'this is offer\'s initial message. it can\'t be too long but has to be long enought to try the interface.'
end
