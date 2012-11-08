Fabricator(:polymorphic_proposal) do
end
=begin
Fabricator(:polymorphic_composer) do
  #Relations
  after_build do |user|
    user.profile = Fabricate.build(:profile,user:user)
    user.things << Fabricate.build(:thing,user:user)
    user.requests << Fabricate.build(:request,user:user)
  end
  #Attributes
  initial_message 'initial message'
end