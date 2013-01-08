Fabricator(:negotiation_proposal, class_name: "Negotiation::Proposal") do
  transient   :offer
  negotiation nil
  composer    nil
  receiver    nil
  money       nil

  after_build do |negotiation|
    negotiation.composer = Fabricate.build(:negotiation_proposal_composer,
                                            user_id:offer.composer._id,
                                            user_name:offer.composer.name,
                                            image:offer.composer.image,
                                            products:offer.composer.products)

    negotiation.receiver = Fabricate.build(:negotiation_proposal_receiver,
                                            user_id:offer.receiver._id,
                                            user_name:offer.receiver.name,
                                            image:offer.receiver.image,
                                            products:offer.receiver.products)
  end
end

# seguir aqui mañana
# falta hacer la fabrica de proposal con dinero y las d elos niveles inferiores
#
