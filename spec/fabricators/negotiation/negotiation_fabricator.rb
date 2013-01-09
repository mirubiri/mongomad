Fabricator(:negotiation) do
  proposals nil
  messages  nil

  after_build do |negotiation|
    offer = Fabricate(:offer)

    proposal = Fabricate.build(:negotiation_proposal, offer:offer)
    negotiation.proposals << proposal

    message = Fabricate.build(:negotiation_message, offer:offer)
    negotiation.messages << message

    user_composer = User.find(offer.composer.user._id)
    user.composer.negotiations << negotiation

    user_receiver = User.find(offer.receiver.user._id)
    user.receiver.negotiations << negotiation
  end
end

# no se como eliminar la que crea y meter una con dinero.