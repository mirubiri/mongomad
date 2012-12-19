Fabricator(:request) do
  user_id   'user_id'
  user_name 'user_name'
  text      'el texto de mi peticion que es un poco largo'
  image     { File.open('app/assets/images/rails.png') }
end
