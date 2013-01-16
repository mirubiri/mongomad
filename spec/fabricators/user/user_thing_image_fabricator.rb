Fabricator(:user_thing_image, class_name: "User::Thing::Image") do
  thing nil
  file  { File.open('app/assets/images/car.png') }
end
