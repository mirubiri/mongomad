Fabricator(:user) do
  after_build do |user|
    #Incrustadas
    user.profile = Fabricate(:profile)
    user.things << Fabricate(:thing)
    user.requests << Fabricate(:request)

    #Relacionadas
  end
end