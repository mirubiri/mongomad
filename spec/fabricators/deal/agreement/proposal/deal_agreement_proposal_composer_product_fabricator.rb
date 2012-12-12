Fabricator(:deal_agreement_proposal_composer_product, class_name: "Deal::Agreement::Proposal::Composer::Product") do
  composer                  nil
  secondary_images(count:1) { Fabricate.build(:deal_agreement_proposal_composer_product_image) }
  thing_id                  'thing_id'
  name                      'name'
  description               'description'
  quantity                  5
  main_image                'app/assets/images/rails.png'
end
