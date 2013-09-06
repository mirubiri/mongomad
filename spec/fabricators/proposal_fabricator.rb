Fabricator(:proposal) do
  transient :container
  proposal_container do |attrs|
    Fabricate.build(:offer, proposal: nil) if attrs[:container] == :offer
    Fabricate.build(:negotiation, proposals: nil) if attrs[:container] == :negotiation
    Fabricate.build(:deal, proposals: nil) if attrs[:container] == :deal
  end

  # Buscar la forma de introducir los productos de ambos usuarios
end
