Fabricator(:product) do
  transient :item
  item { Fabricate(:item) }

  _id         { |attrs| attrs[:item].id }
  owner_id    { |attrs| attrs[:item].user.id }
  name        { |attrs| attrs[:item].name }
  description { |attrs| attrs[:item].description }
  quantity    3

  proposal { |attrs| Fabricate(:proposal,composer:attrs[:item].user) }

end

# Fabricator(:offer_composer_product, class_name: 'Offer::Composer::Product') do
#   transient   :thing
#   composer    nil
#   thing_id    { |attrs| attrs[:thing].id }
#   name        { |attrs| attrs[:thing].name }
#   description { |attrs| attrs[:thing].description }
#   quantity    1
# end
