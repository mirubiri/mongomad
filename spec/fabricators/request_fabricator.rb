Fabricator(:request) do
  user_id   { Fabricate.build(:user, thing:nil)._id }
  user_name { Fabricate.build(:user, thing:nil).name }
  text      'el texto de mi peticion que es un poco largo y ocupa mas de una linea'
  image     'image_path'
end
