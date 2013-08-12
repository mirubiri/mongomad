Fabricator(:profile) do
  user { Fabricate.build(:user,profile:nil) }
  language 'english'
#  image            ActionDispatch::Http::UploadedFile.new({
#    :filename     => 'user.png',
#    :content_type => 'image/png',
#    :tempfile     => File.new('app/assets/images/user.png')})
end

# Fabricator(:user_medico_profile, from: 'User::Profile') do
#   first_name       'Eduardo'
#   last_name    'Hormilla'
#   gender        'man'
#   birth_date '06-05-1982'
#   language 'english'
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'medico.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/medico.jpg')})
# end

# Fabricator(:user_sergio_profile, from: 'User::Profile') do
#   first_name       'Sergio'
#   last_name    'de Torre'
#   gender        'man'
#   birth_date '23-12-1982'
#   language 'english'
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'sergio.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/sergio.jpg')})
# end

# Fabricator(:user_sofia_profile, from: 'User::Profile') do
#   first_name       'Sofia'
#   last_name    'Contero'
#   gender        'woman'
#   birth_date '23-11-1989'
#   language 'english'
#   image       ActionDispatch::Http::UploadedFile.new({
#     :filename     => 'sofia.jpg',
#     :content_type => 'image/jpg',
#     :tempfile     => File.new('app/assets/images/sofia.jpg')})
# end
