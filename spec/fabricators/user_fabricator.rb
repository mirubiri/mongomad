Fabricator(:user) do
  after_build do |user|
    user.profile = Fabricate.build(:profile,user:user)
  end
end