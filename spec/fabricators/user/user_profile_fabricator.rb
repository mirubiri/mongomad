Fabricator(:user_profile, class_name: "User::Profile") do
  user             nil
  name             { Faker::Name.first_name }
  surname          { Faker::Name.last_name }
  nickname         { Faker::Internet.user_name }
  sex              'man'
  country          { Faker::Address.country }
  delivery_address nil
  phone_number     nil
  website          nil
  birth_date       '10-10-2000'
  image            { File.open('app/assets/images/user.png') }
  image_name       'user.png'

  after_build do |profile|
    profile.image.store!
  end
end

Fabricator(:user_medico_profile, from: "User::Profile") do
  name       'Eduardo'
  surname    'Hormilla'
  nickname   'medico'
  sex        'man'
  country    'Spain'
  birth_date '06-05-1982'
  image      { File.open('app/assets/images/medico.jpg') }
  image_name 'medico.jpg'

  after_build do |profile|
    profile.image.store!
  end
end

Fabricator(:user_sergio_profile, from: "User::Profile") do
  name       'Sergio'
  surname    'de Torre'
  nickname   'deTorre82'
  sex        'man'
  country    'Spain'
  birth_date '23-12-1982'
  image      { File.open('app/assets/images/sergio.jpg') }
  image_name 'sergio.jpg'

  after_build do |profile|
    profile.image.store!
  end
end
