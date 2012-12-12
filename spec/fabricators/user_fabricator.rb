Fabricator(:user) do
  profile         { Fabricate.build(:user_profile) }
  things(count:1) { Fabricate.build(:user_thing) }
  requests        nil
  sent_offers     nil
  received_offers nil
  negotiations    nil
  deals           nil
  email           { Faker::Internet.email }
  password        'password'

  after_create do |user|
    offer=Fabricate.build(:offer)
    offer.composer.image=user.profile.image
    user.received_offers<<offer
  end

end
