Fabricator(:negotiation) do
   transient    :offer
   offer        { Fabricate(:offer) }
   _users       { |attrs| [ attrs[:offer].user_sender,attrs[:offer].user_receiver ] }
   proposals    { |attrs| [ attrs[:offer].proposal ] }
   user_sheets  { |attrs| attrs[:offer].user_sheets }
   messages     { |attrs| [ Fabricate.build(:message,text:attrs[:offer].message) ] }
   # Faltan los mensajes
end

