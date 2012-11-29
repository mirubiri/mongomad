Fabricator(:deal_agreement_proposal_receiver, class_name: "Deal::Agreement::Proposal::Receiver") do
  proposal nil
  products nil
  user_id 'user_id'
  name 'name'
  image { File.open('app/assets/images/rails.png') }
end