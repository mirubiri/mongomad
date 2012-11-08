Fabricator(:offer) do
  initial_message 'initial message'
  after_build do |offer|
    offer.composer = Fabricate.build(:polymorphic_composer,offer:offer)
    offer.receiver = Fabricate.build(:polymorphic_receiver,offer:offer)
  end
end