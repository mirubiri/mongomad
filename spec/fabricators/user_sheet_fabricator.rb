Fabricator(:user_sheet) do
  transient :user
  user { Fabricate(:user) }
  _id        { |attrs| attrs[:user].id }
  first_name { |attrs| attrs[:user].profile.first_name }
  last_name  { |attrs| attrs[:user].profile.last_name }
  nick       { |attrs| attrs[:user].nick }
end
