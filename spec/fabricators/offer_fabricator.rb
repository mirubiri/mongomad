Fabricator(:offer) do
  offer_inbox
  offer_outbox
  after_build do |offer|
    offer.composer=Fabricate(:composer,offer: offer)
    offer.receiver=Fabricate(:receiver,offer: offer)
    offer.money=Fabricate(:money,offer: offer)
  end
end