User.all.destroy
Request.all.destroy
Offer.all.destroy
Negotiation.all.destroy
Deal.all.destroy

sergio = Fabricate(:user_with_things)
sergio.email = 'sergio@improcex.com'
sergio.profile.name = 'Sergio'
sergio.profile.surname = 'de Torre'
sergio.profile.nickname = 'deTorre82'
sergio.profile.country = 'España'
sergio.profile.image = File.open('app/assets/images/receiver.png')
sergio.save

medico = Fabricate(:user_with_things)
medico.email = 'medico@improcex.com'
medico.profile.name = 'Eduardo'
medico.profile.surname = 'Hormilla'
medico.profile.nickname = 'medico82'
medico.profile.country = 'España'
medico.profile.image = File.open('app/assets/images/composer.png')
medico.save

rand(5..8).times do
  Fabricate(:request, user:sergio)
end

rand(1..3).times do
  sergio.things.all.destroy
  rand(1..3).times do
    sergio.things << Fabricate.build(:user_thing)
  end
  medico.things.all.destroy
  rand(1..3).times do
    medico.things << Fabricate.build(:user_thing)
  end
  Fabricate(:offer, users:[sergio, medico])
end

sergio.offers.each do |offer|
  Fabricate(:negotiation, offer:offer, users:[sergio, medico])
end

message = Fabricate.build(:negotiation_message, offer:sergio.offers.last)
sergio.negotiations.each do |negotiation|
  negotiation.messages << message
  Fabricate(:deal, negotiation:negotiation, users:[sergio, medico])
end

message = Fabricate.build(:deal_message, message:sergio.negotiations.last.messages.last)
sergio.deals.each do |deal|
  deal.messages << message
end

User.all.count
Request.all.count
Offer.all.count
Negotiation.all.count
Deal.all.count

sergio.email
