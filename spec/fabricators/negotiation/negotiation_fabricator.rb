Fabricator(:negotiation) do
  transient :offer
  offer               { Fabricate(:offer) }
  users               { |attrs| [ attrs[:offer].user_composer, attrs[:offer].user_receiver ] }
  proposals(count: 1) { |attrs| Fabricate.build(:negotiation_proposal, offer:attrs[:offer]) }
  messages(count: 1)  { |attrs| Fabricate.build(:negotiation_message, composer:attrs[:offer].composer) }
  token_user_id       { |attrs| attrs[:users].first._id }
  token_state         "propose"
end
