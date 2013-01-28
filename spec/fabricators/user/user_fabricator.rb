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

=begin #Fabrica minima
Fabricator(:user_with_things, from: :user) do
	things(count:1) { Fabricate.build(:user_thing) }
end
=end

Fabricator(:user_with_things, from: :user) do
  things(count:6) { Fabricate.build(:user_thing) }

  after_build do |user|
    user.things[1].image = File.open('app/assets/images/house.png')
    user.things[2].image = File.open('app/assets/images/bicycle.png')
    user.things[3].image = File.open('app/assets/images/coffee.png')
    user.things[4].image = File.open('app/assets/images/monkey.png')
    user.things[5].image = File.open('app/assets/images/link.png')
  end
end
