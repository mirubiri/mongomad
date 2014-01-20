Fabricator(:deal) do
  transient   :negotiation
  negotiation { Fabricate(:negotiation) }
  users       { |attrs| attrs[:negotiation].users }
  user_sheets { |attrs| [ Fabricate.build(:user_sheet, user:attrs[:users].first), Fabricate.build(:user_sheet, user:attrs[:users].last) ] }
  proposals   { |attrs| attrs[:negotiation].proposals }
  messages    { |attrs| attrs[:negotiation].messages }
end
