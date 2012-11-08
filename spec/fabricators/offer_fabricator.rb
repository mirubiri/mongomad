Fabricator(:offer) do
  initial_message 'initial message'
  after_build do |offer|
    offer.composer = Fabricate.build(:composer,offer:offer)
    offer.receiver = Fabricate.build(:receiver,offer:offer)
  end
end