Fabricator(:user_thing, class_name: "User::Thing") do
  user                      nil
  secondary_images(count:1) { Fabricate.build(:user_thing_image) }
  name                      'name'
  description               'description'
  stock                     7
  main_image                'main_image_path'
end
