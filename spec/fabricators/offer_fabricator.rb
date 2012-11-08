Fabricator(:offer) do
  #Relations
  after_build do |offer|
    offer.composer = Fabricate.build(:polymorphic_composer,offer:offer)
    offer.receiver = Fabricate.build(:polymorphic_receiver,offer:offer)
  end
  #Attributes
  initial_message 'initial message'
end