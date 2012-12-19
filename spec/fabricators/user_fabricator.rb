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

    request=Fabricate.build(:request)
    user.requests<<request

    received_offer=Fabricate.build(:offer)
    user.received_offers<<received_offer

    sent_offer=Fabricate.build(:offer)
    user.sent_offers<<sent_offer

    negotiation=Fabricate.build(:negotiation)
    user.negotiations<<negotiation

    deal=Fabricate.build(:deal)
    user.deals<<deal

    #Añadir mas cosas aleatoriamente

    image_path=user.profile.image.path
    user.things.each do |thing|
      thing.main_image=image_path
    end

  end
end
