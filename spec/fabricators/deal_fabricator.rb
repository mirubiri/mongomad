Fabricator(:deal) do
  transient   :negotiation
  negotiation { Fabricate(:negotiation) }
  users       { |attrs| attrs[:negotiation].users }
  proposals   { |attrs| attrs[:negotiation].proposals }
  messages    { |attrs| attrs[:negotiation].messages }
end
