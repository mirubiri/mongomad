Fabricator(:negotiation) do
  proposals nil
  messages nil

  after_build do |negotiation|
    offer = Fabricate(:offer)
    proposal = Fabricate.build(:negotiation_proposal, offer:offer)
    negotiation.proposals << proposal

    message = Fabricate.build(:negotiation_message, offer:offer)
    negotiation.messages << message
  end
end

## TODO: Esto esta bien? :)
Fabricator(:negotiation_with_money, from: :negotiation) do
  proposal = Fabricate.build(:negotiation_proposal, offer:offer)
  negotiation.proposals.last = proposal



end

=begin
  money { Fabricate.build(:proposal_with_money, user_id:nil) }

  after_build do |negotiation|
    negotiation.proposals.last.money = Fabricate.build(:proposal_with_money, offer:offer) }
  end
end

  money { Fabricate.build(:offer_money, user_id:nil) }

  after_build do |offer|
    offer.money.user_id = offer.composer._id
  end
end
