Fabricator(:deal_agreement_proposal_receiver_product_image, class_name: "Deal::Agreement::Proposal::Receiver::Product::Image") do
  product nil
  file    { File.open('app/assets/images/rails.png') }
end
