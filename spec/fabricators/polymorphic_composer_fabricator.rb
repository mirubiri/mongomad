Fabricator(:polymorphic_composer) do
  #Relations
  offer
  #Attributes
end
=begin

rescue Exception => e

end  #Relations
  after_build do |polymorphic_composer|
    polymorphic_composer.composer = Fabricate.build(:profile,user:user)
  end
  #Attributes
  initial_message 'initial message'
=end