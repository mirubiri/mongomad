Fabricator(:request) do
  user_id   'user_id'
  user_name 'user_name'
  text      'text'
  image     { File.open('app/assets/images/rails.png') }
end