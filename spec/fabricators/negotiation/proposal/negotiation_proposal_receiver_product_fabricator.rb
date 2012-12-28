Fabricator(:negotiation_proposal_receiver_product, class_name: "Negotiation::Proposal::Receiver::Product") do
  receiver         nil
  secondary_images nil
  thing_id         'thing_id'
  name             'name'
  description      'description'
  quantity         10
  main_image       'main_image_path'
end
