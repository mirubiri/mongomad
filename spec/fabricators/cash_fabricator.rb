Fabricator(:cash) do
  proposal
  money    { Money.new(rand(1..5000)) }
  owner_id { |attrs| attrs[:proposal].composer_id }
  images   { [ Fabricate.build(:image_money) ] }
end
