Fabricator(:product) do
  transient   :item
  item        { Fabricate(:item) }
  proposal    { |attrs| Fabricate(:proposal, composer:attrs[:item].user) }
  id          { |attrs| attrs[:item].id }
  name        { |attrs| attrs[:item].name }
  description { |attrs| attrs[:item].description }
  owner_id    { |attrs| attrs[:item].user.id }
  images      { |attrs| attrs[:item].images }
end
