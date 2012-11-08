Fabricator(:proposal) do
  polymorphic_proposal { Fabricate(:negotiation) }
  after_build do |proposal|
    proposal.composer = Fabricate.build(:composer,polymorphic_composer:proposal)
    proposal.receiver = Fabricate.build(:receiver,polymorphic_receiver:proposal)
  end
end