Fabricator(:product) do
  proposal { Fabricate.build(:proposal, sender_products:nil, receiver_products:nil) }
  sheet    { Fabricate.build(:item_sheet, container: :product) }
  quantity 2
end

# Fabricator(:offer_composer_product, class_name: 'Offer::Composer::Product') do
#   transient   :thing
#   composer    nil
#   thing_id    { |attrs| attrs[:thing].id }
#   name        { |attrs| attrs[:thing].name }
#   description { |attrs| attrs[:thing].description }
#   quantity    1
# end
