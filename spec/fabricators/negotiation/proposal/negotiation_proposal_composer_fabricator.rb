Fabricator(:negotiation_proposal_composer, class_name: "Negotiation::Proposal::Composer") do
  proposal nil
  products nil
  user_id 'user_id'
  name 'name'
  image { File.open('app/assets/images/rails.png') }
end