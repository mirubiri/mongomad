Fabricator(:deal) do
  transient   :negotiation
  negotiation { Fabricate(:negotiation) }
  users       { |attrs| attrs[:negotiation].users }
  user_sheets { |attrs| attrs[:negotiation].user_sheets }
  proposals   { |attrs| attrs[:negotiation].proposals }
  messages    { |attrs| attrs[:negotiation].messages }
end
