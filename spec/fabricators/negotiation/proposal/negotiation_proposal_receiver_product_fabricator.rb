Fabricator(:negotiation_proposal_receiver_product, class_name: "Negotiation::Proposal::Receiver::Product") do
  receiver                  nil
  secondary_images(count:1) { Fabricate.build(:negotiation_proposal_receiver_product_image) }
  thing_id                  'thing_id'
  name                      'name'
  description               'description'
  quantity                  5
  main_image                'main_image_path'
end
