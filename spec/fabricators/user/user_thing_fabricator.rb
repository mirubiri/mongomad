Fabricator(:user_thing, class_name: "User::Thing") do
  user            { Fabricate.build(:user, things:nil) }
  images(count:1) { Fabricate.build(:user_thing_image, thing:nil) }
  name            'name'
  description     'description'
  stock           1
  main_image      { |attrs| attrs[:images] &&
                            attrs[:images].last.file.url }
end
