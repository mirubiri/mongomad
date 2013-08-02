Fabricator(:user_profile, class_name: 'User::Profile') do
  user             nil
  first_name       { Faker::Name.first_name }
  last_name        { Faker::Name.last_name }
  gender           'male'
  birth_date       '10-10-2000'
  language 'english'
  image            ActionDispatch::Http::UploadedFile.new({
    :filename     => 'user.png',
    :content_type => 'image/png',
    :tempfile     => File.new('app/assets/images/user.png')})
end


