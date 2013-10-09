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