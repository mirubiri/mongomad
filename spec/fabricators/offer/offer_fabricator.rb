Fabricator(:offer) do
  users(count: 2) { Fabricate.build(:user_with_things) }
  composer        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].first) }
  receiver        { |attrs| Fabricate.build(:offer_composer, user:attrs[:users].last) }
  money           nil
  initial_message 'this is offer\'s initial message. it can\'t be too long but has to be long enought to try the interface.'
end

Fabricator(:offer_with_money, from: :offer) do
  money { |attrs| Fabricate.build(:offer_money, user_id:attrs[:users].first._id) }
end
