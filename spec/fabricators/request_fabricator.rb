Fabricator(:request) do
  user { Fabricate.build(:user,requests:nil)}
  text 'text'
end