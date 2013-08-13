Fabricator(:user_sheet) do
  transient  :container, :nick
  nick       { attrs[:nick] }
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }

  user_sheet_container do |attrs|
    Fabricate.build(:user, sheet:nil) if attrs[:container] == :user
    Fabricate.build(:offers, sender_sheet:nil, receiver_sheet:nil) if attrs[:container] == :offer
    Fabricate.build(:negotiation, negotiators:[nil, nil]) if attrs[:container] == :negotiation
    Fabricate.build(:deal, signers:[nil, nil]) if attrs[:container] == :deal
  end
end
