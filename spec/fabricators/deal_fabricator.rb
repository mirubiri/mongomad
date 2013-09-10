Fabricator(:deal) do
   transient    :negotiation
   negotiation  { Fabricate(:negotiation) }
   _users       { |attrs| attrs[:negotiation]._users }
   proposals    { |attrs| attrs[:negotiation].proposals }
   user_sheets  { |attrs| attrs[:negotiation].user_sheets }
   messages     { |attrs| attrs[:negotiation].messages }
end
