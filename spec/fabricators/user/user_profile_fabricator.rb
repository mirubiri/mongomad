Fabricator(:user_profile, class_name: 'User::Profile') do
  user             nil
  name             { Faker::Name.first_name }
  surname          { Faker::Name.last_name }
  nick             { Faker::Internet.user_name }
  sex              'man'
  country          { Faker::Address.country }
  delivery_address nil
  phone_number     nil
  website          nil
  birth_date       '10-10-2000'
  image  ActionDispatch::Http::UploadedFile.new({
    :filename     => 'user.png',
    :content_type => 'image/png',
    :tempfile     => File.new('app/assets/images/user.png')})

end

Fabricator(:user_medico_profile, from: 'User::Profile') do
  name       'Eduardo'
  surname    'Hormilla'
  nick       'medico'
  sex        'man'
  country    'Spain'
  birth_date '06-05-1982'
  image  ActionDispatch::Http::UploadedFile.new({
    :filename     => 'medico.jpg',
    :content_type => 'image/jpg',
    :tempfile     => File.new('app/assets/images/medico.jpg')})
end

Fabricator(:user_sergio_profile, from: 'User::Profile') do
  name       'Sergio'
  surname    'de Torre'
  nick       'deTorre82'
  sex        'man'
  country    'Spain'
  birth_date '23-12-1982'
  image  ActionDispatch::Http::UploadedFile.new({
    :filename     => 'sergio.jpg',
    :content_type => 'image/jpg',
    :tempfile     => File.new('app/assets/images/sergio.jpg')})
end
