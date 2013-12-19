Fabricator(:negotiation) do
   transient    :offer
   offer        { Fabricate(:offer) }
   _users       { |attrs| [ attrs[:offer].user_composer,attrs[:offer].user_receiver ] }
   proposals    { |attrs| [ attrs[:offer].proposal ] } 
   messages     { |attrs| [ Fabricate.build(:message, text:attrs[:offer].message) ] }
   state        'in progress'
end