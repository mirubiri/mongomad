Fabricator(:user_sheet) do
  transient :container
  initialize_with { Fabricate.build(:user).sheet }
  user_sheet_container { |attrs| Fabricate.build(attrs[:container]) if attrs[:container] }
end
