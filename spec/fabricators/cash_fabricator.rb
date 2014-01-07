Fabricator(:cash) do
  proposal
  money     { Money.new(100) }
  owner_id  { |attrs| attrs[:proposal].composer_id }
  images    { [ Fabricate.build(:image_money) ] }
end
