Fabricator(:user) do
  after_build do |user|
    user.profile = Fabricate.build(:profile,user:user)
    user.things << Fabricate.build(:thing,user:user)
    user.request << Fabricate.build(:request,user:user)
  end
end