Fabricator(:request) do
  user_id   'user_id'
  user_name 'user_name'
  text      'el texto de mi peticion que es un poco largo'
  image     'image_path'

  after_build do |request|

    image_path='/images/rails.png'
    request.image=image_path

  end
end
