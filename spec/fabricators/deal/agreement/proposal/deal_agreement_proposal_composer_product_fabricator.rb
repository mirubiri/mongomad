Fabricator(:deal_agreement_proposal_composer_product, class_name: "Deal::Agreement::Proposal::Composer::Product") do
  composer         nil
  secondary_images nil
  thing_id         'thing_id'
  name             'name'
  description      'description'
  quantity         10
  main_image       'main_image_path'
end
