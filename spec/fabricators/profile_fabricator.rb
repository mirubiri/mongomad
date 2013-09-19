Fabricator(:profile) do
  user       { Fabricate.build(:user, profile:nil) }
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  language   'english'
#  image            ActionDispatch::Http::UploadedFile.new({
#    :filename     => 'user.png',
#    :content_type => 'image/png',
#    :tempfile     => File.new('app/assets/images/user.png')})
end

Fabricator(:user_medico_profile, from: :profile) do
  first_name 'Eduardo'
  last_name  'Hormilla'
  language   'spanish'
  # image       ActionDispatch::Http::UploadedFile.new({
  #   :filename     => 'medico.jpg',
  #   :content_type => 'image/jpg',
  #   :tempfile     => File.new('app/assets/images/medico.jpg')})
end

Fabricator(:user_sergio_profile, from: :profile) do
  first_name 'Sergio'
  last_name  'de Torre'
  language 'english'
  # image       ActionDispatch::Http::UploadedFile.new({
  #   :filename     => 'sergio.jpg',
  #   :content_type => 'image/jpg',
  #   :tempfile     => File.new('app/assets/images/sergio.jpg')})
end
