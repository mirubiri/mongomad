Fabricator(:negotiation_proposal_receiver, class_name: "Negotiation::Proposal::Receiver") do
  transient :receiver
  proposal  nil
  products  do |attrs|
    products = []
    attrs[:receiver].products.each do |product|
      products << Fabricate.build(:negotiation_proposal_receiver_product, product:product)
    end
    products
  end
  user_id   { |attrs| attrs[:receiver].user_id }
  name      { |attrs| attrs[:receiver].name }
  image     { |attrs| attrs[:receiver].image }
end
