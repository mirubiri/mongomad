Fabricator(:deal_agreement_proposal_composer_product_image, class_name: "Deal::Agreement::Proposal::Composer::Product::Image") do
  product nil
  file    { File.open('app/assets/images/rails.png') }
end
