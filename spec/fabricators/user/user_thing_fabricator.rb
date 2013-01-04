Fabricator(:user_thing, class_name: "User::Thing") do
  user            { Fabricate.build(:user, things:nil) }
  images(count:1) { Fabricate.build(:user_thing_image, thing:nil) }
  name            'name'
  description     'description'
  stock           1
  main_image      { |attrs| attrs[:images].try {|images| images.last.file.url} }

  after_build do |thing|
  	thing.user.try { |user| user.things << thing }
  end
end
