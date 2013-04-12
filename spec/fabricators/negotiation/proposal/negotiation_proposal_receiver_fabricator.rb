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
  nick      { |attrs| attrs[:receiver].nick }
  image_url { |attrs| attrs[:receiver].image_url }
end
