Fabricator(:cash) do
	transient :owner
	owner     { :composer_id }
	proposal
  owner_id  { |attrs| attrs[:proposal].send(attrs[:owner]) }
  money     { Money.new(100) }
  images    { [ Fabricate.build(:image_money) ] }
end
