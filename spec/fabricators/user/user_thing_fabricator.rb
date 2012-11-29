Fabricator(:user_thing, class_name: "User::Thing") do
  user             nil
  secondary_images nil
  name             'name'
  description      'description'
  stock            2
  main_image       nil
end