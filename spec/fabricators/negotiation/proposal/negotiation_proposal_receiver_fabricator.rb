Fabricator(:negotiation_proposal_receiver, class_name: "Negotiation::Proposal::Receiver") do
  proposal          nil
  products(count:1) { Fabricate.build(:negotiation_proposal_receiver_product) }
  user_id           'user_id'
  name              'name'
  image             { File.open('app/assets/images/rails.png') }
end