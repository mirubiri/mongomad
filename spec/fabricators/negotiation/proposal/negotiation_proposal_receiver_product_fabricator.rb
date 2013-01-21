Fabricator(:negotiation_proposal_receiver_product, class_name: "Negotiation::Proposal::Receiver::Product") do
  transient   :product
  receiver    nil
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
  image       { |attrs| File.open(attrs[:product].image.path) }
end
