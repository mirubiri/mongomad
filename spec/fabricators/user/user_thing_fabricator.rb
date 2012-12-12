Fabricator(:user_thing, class_name: "User::Thing") do
  user                      nil
  secondary_images(count:1) { Fabricate.build(:user_thing_image) }
  name                      'name'
  description               'description'
  stock                     1
  main_image                'app/assets/images/rails.png'
end
