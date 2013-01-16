user = Fabricate(:user_with_things)
3.times do
  user.things << Fabricate.build(:user_thing)
end
5.times do
  offer = Fabricate(:offer, users:[user,Fabricate(:user_with_things)])
end
user.email
