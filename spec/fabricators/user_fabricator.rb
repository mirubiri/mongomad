Fabricator(:user) do
  email    { Faker::Internet.email }
  password 'password'
  nick     { Faker::Internet.user_name }
  profile  { Fabricate.build(:profile) }
end

Fabricator(:user_with_items, from: :user) do
  after_build do |user|
    user.items = 3.times.map { Fabricate(:item,user:user) }
  end
end

Fabricator(:user_with_sent_offers,from: :user_with_items) do
  after_build do |user|
    user.sent_offers << Fabricate(:offer, user_composer: user)
  end
end

Fabricator(:user_with_received_offers,from: :user_with_items) do
  after_build do |user|
    user.received_offers << Fabricate(:offer, user_receiver: user)
  end
end