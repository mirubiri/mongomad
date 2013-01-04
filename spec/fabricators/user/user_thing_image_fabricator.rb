Fabricator(:user_thing_image, class_name: "User::Thing::Image") do
  thing { Fabricate.build(:user_thing, images:nil) }
  file  { File.open('app/assets/images/rails.png') }

  after_build do |image|
    
    image.thing.try { |thing| thing.main_image = image.thing.images.last.file.url }
  end
end
