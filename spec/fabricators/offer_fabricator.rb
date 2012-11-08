Fabricator(:offer) do
  initial_message 'initial message'
  after_build do |offer|
    offer.composer = Fabricate.build(:composer,polymorphic_composer:offer)
    offer.receiver = Fabricate.build(:receiver,polymorphic_receiver:offer)
  end
end