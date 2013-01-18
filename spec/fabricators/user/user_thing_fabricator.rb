Fabricator(:user_thing, class_name: "User::Thing") do
  user            nil
  name            'name'
  description     'this is thing\'s description. my thing is the most beautiful you have ever seen! if you need it, make and offer and it\'s yours!'
  stock           1
  image           { File.open('app/assets/images/user.png') }
end
