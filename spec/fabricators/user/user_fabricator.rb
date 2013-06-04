Fabricator(:user) do
  profile         { Fabricate.build(:user_profile) }
  things          nil
  requests        nil
  sent_offers     nil
  received_offers nil
  negotiations    nil
  deals           nil
  email           { Faker::Internet.email }
  password        'password'
end

Fabricator(:user_with_things, from: :user) do
  things(count:2) { Fabricate.build(:user_thing) }
end

Fabricator(:user_medico, from: :user) do
  profile         { Fabricate.build(:user_medico_profile) }
  things(count:1) { Fabricate.build(:user_thing) }
  email           'medico@improcex.com'
  password        'medico'

  after_build do |user|
    user.things << Fabricate.build(:user_medico_thing_cartera)
    user.things << Fabricate.build(:user_medico_thing_mp3)
  end
end

Fabricator(:user_sergio, from: :user) do
  profile         { Fabricate.build(:user_sergio_profile) }
  things(count:1) { Fabricate.build(:user_thing) }
  email           'sergio@improcex.com'
  password        'sergio'

  after_build do |user|
    user.things << Fabricate.build(:user_sergio_thing_cartera)
    user.things << Fabricate.build(:user_sergio_thing_mando)
  end
end

Fabricator(:user_sofia, from: :user) do
  profile         { Fabricate.build(:user_sofia_profile) }
  things(count:1) { Fabricate.build(:user_thing) }
  email           'sergio@improcex.com'
  password        'sergio'

  after_build do |user|
    user.things << Fabricate.build(:user_sofia_thing_perro)
    user.things << Fabricate.build(:user_sofia_thing_choza)
  end
end
