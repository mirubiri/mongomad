Fabricator(:negotiation_proposal_receiver, class_name: "Negotiation::Proposal::Receiver") do
  transient :user
  proposal  nil
  products  do |attrs|
    attrs[:user].things.each do |thing|
      Fabricate.build(:negotiation_proposal_receiver_product, thing:thing)
    end
  end
  user_id   { |attrs| attrs[:user]._id }
  name      { |attrs| attrs[:user].profile.name }
  image     { |attrs| attrs[:user].profile.image.url }
end
