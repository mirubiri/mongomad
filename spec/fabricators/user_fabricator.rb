Fabricator(:user) do
  after_build do |user|
    #Incrustadas
    user.profile = Fabricate.build(:profile)
    user.things << Fabricate.build(:thing)
    user.requests << Fabricate.build(:request)

    #Relacionadas
  end
end