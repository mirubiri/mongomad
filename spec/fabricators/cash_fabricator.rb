Fabricator(:cash) do
	transient :owner
	owner     { :composer_id }
	proposal
  _id  { |attrs| attrs[:proposal].send(attrs[:owner]) }
  _money    { Money.new(100) }
end
