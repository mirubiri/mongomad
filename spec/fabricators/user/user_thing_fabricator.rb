Fabricator(:user_thing, class_name: "User::Thing") do
  user            nil
  images(count:1) { Fabricate.build(:user_thing_image) }
  name            'name'
  description     'this is thing\'s description. my thing is the most beautiful you have ever seen! if you need it, make and offer and it\'s yours!'
  stock           1
  main_image      { |attrs| attrs[:images].last.file.url }
end
