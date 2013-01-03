Fabricator(:request) do
  user_id   nil
  user_name nil
  text      'el texto de mi peticion que es un poco largo y ocupa mas de una linea'
  image     'image_path'

  after_build do |request|
    user=Fabricate.build(:user)
    request.user_id||=user._id
    request.user_name||=user.profile.name
  end
end
