Fabricator(:thing) do
  user {Fabricate.build(:user,things:nil)}
  name 'name'
  description 'description'
  stock 5
end