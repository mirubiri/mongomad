Fabricator(:item_sheet) do
  transient :container
  name        { Faker::Lorem.word }
  description { Faker::Lorem.sentence }

  sheet_container do |attrs|
    Fabricate.build(:item,sheet: nil) if attrs[:container]==:item
    Fabricate.build(:product,sheet: nil) if attrs[:container]==:product
  end
end
