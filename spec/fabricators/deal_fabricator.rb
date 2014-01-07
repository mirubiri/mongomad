Fabricator(:deal) do
  transient   :negotiation
  negotiation { Fabricate(:negotiation) }
  _users      { |attrs| attrs[:negotiation]._users }
  proposals   { |attrs| attrs[:negotiation].proposals }
  messages    { |attrs| attrs[:negotiation].messages }
end
