Fabricator(:proposal) do
  transient :container,:left,:right

  proposal_container { |attrs| Fabricate.build(attrs[:container], proposal: nil) if attrs[:container] }

  # Buscar la forma de introducir los productos de ambos usuarios
end
