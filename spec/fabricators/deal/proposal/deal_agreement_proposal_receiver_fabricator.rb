Fabricator(:deal_agreement_proposal_receiver, class_name: 'Deal::Agreement::Proposal::Receiver') do
  transient         :receiver
  proposal          nil
  products  do |attrs|
    products = []
    attrs[:receiver].products.each do |product|
      products << Fabricate.build(:deal_agreement_proposal_receiver_product, product:product)
    end
    products
  end
  nick              { |attrs| attrs[:receiver].nick }
  image_fingerprint { |attrs| attrs[:receiver].image_fingerprint }
end
