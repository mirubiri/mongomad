=begin
Fabricator(:negotiation) do
   transient           :offer
   offer               { Fabricate(:offer) }
end
=end
