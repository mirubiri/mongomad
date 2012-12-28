Fabricator(:user_thing, class_name: "User::Thing") do
  user             nil
  secondary_images nil
  name             'name'
  description      'description'
  stock            10
  main_image       'main_image_path'
end
