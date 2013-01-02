Fabricator(:user_thing_image, class_name: "User::Thing::Image") do
  thing do

          Fabricate.build(:user_thing,secondary_images:nil)
        end
  file  { File.open('app/assets/images/rails.png') }
end
