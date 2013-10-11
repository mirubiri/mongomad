Fabricator(:negotiation) do
   transient    :offer
   offer        { Fabricate(:offer) }
   _users       { |attrs| [ attrs[:offer].user_composer,attrs[:offer].user_receiver ] }
   proposals    { |attrs| [ attrs[:offer].proposal ] } 
   messages     { |attrs| [ Fabricate.build(:message, text:attrs[:offer].message) ] }
   after_build do |negotiation|
   	 negotiation.initial_state
   end
end