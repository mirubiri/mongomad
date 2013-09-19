Fabricator(:user) do
  email           { Faker::Internet.email }
  password        'password'
  nick            { Faker::Internet.user_name }
  profile         { Fabricate.build(:profile) }
end

Fabricator(:user_with_items, from: :user) do
  after_build do |user|
    user.items = 3.times.map { Fabricate(:item,user:user) }
  end
end

Fabricator(:user_sent_offers,from: :user_with_items) do
  after_build do |user|
    user.sent_offers << Fabricate(:offer,user_composer: user)
  end
end

Fabricator(:user_received_offers,from: :user_with_items) do
  after_build do |user|
    user.received_offers << Fabricate(:offer,user_receiver: user)
  end
end

Fabricator(:user_medico, from: :user) do
  email           'medico@improcex.com'
  password        'medico'
  nick            'medico82'
  profile         { Fabricate.build(:user_medico_profile) }

  after_build do |user|
    user.items << Fabricate.build(:user_medico_item_cartera)
    user.items << Fabricate.build(:user_medico_item_mp3)
  end
end

Fabricator(:user_sergio, from: :user) do
  email           'sergio@improcex.com'
  password        'sergio'
  nick            'detorre'
  profile         { Fabricate.build(:user_sergio_profile) }

  after_build do |user|
    user.items << Fabricate.build(:user_sergio_item_cartera)
    user.items << Fabricate.build(:user_sergio_item_mando)
  end
end
