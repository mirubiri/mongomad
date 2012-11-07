Fabricator(:negotiation) do
  proposals { [Fabricate.build(:proposal)] }
  messages { [Fabricate.build(:message)] }
  token_owner { Fabricate.build(:user)._id }
  token_state true
end