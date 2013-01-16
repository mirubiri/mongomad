Fabricator(:negotiation_proposal_receiver, class_name: "Negotiation::Proposal::Receiver") do
  transient :offer
  proposal  nil
  products  do |attrs|
    products = []
    attrs[:offer].receiver.products.each do |product|
      products << Fabricate.build(:negotiation_proposal_receiver_product, product:product)
    end
    products
  end
  user_id   { |attrs| attrs[:offer].receiver.user_id }
  name      { |attrs| attrs[:offer].receiver.name }
  image     { |attrs| attrs[:offer].receiver.image }
end
