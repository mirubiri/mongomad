Fabricator(:user_sheet) do
  transient :container
  initialize_with { Fabricate.build(:user).sheet }

  user_sheet_container do |attrs|
    Fabricate.build(:offer) if attrs[:container] == :offer
    Fabricate.build(:negotiation) if attrs[:container] == :negotiation
    Fabricate.build(:deal) if attrs[:container] == :deal
  end
end
