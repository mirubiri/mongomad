Fabricator(:negotiation) do
  token_owner { Fabricate.build(:user)._id }
  token_state true

  after_build do |negotiation|
    negotiation.proposals << Fabricate.build(:proposal,polymorphic_proposal:negotiation)
  end
end