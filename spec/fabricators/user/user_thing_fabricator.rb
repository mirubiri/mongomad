Fabricator(:user_thing, class_name: "User::Thing") do
  user                      { Fabricate.build(:user, things:nil) }
  secondary_images(count:1) { Fabricate.build(:user_thing_image, thing:nil) }
  name                      'name'
  description               'description'
  stock                     10
  main_image                { |attrs| attrs[:secondary_images] &&
                                      attrs[:secondary_images].last.file.url }
end