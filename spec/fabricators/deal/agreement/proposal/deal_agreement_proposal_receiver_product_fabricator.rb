Fabricator(:deal_agreement_proposal_receiver_product, class_name: "Deal::Agreement::Proposal::Receiver::Product") do
 transient   :product
  receiver    nil
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
  image       { File.open('app/assets/images/car.png') }
end
