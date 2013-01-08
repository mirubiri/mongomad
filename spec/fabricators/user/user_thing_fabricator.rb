Fabricator(:user_thing, class_name: "User::Thing") do
  user            nil
  images(count:1) { Fabricate.build(:user_thing_image) }
  name            'name'
  description     'description'
  stock           1
  main_image      { |a| a[:images].last.file.url }
end
