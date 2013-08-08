Fabricator(:sheet) do
  transient :container
  name        { Faker::Lorem.word }
  description { Faker::Lorem.sentence }

  sheet_container do |attrs|
    Fabricate.build(:thing,sheet: nil) if attrs[:container]==:thing
    Fabricate.build(:product,sheet: nil) if attrs[:container]==:product
  end
end
