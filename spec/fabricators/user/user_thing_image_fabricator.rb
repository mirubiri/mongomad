Fabricator(:user_thing_image, class_name: "User::Thing::Image") do
  thing { Fabricate.build(:user_thing,secondary_images:nil) }
  file  { File.open('app/assets/images/rails.png') }
end
