Fabricator(:user_sheet) do
  transient  :user
  user       { Fabricate(:user) }
  _id        { |attrs| attrs[:user]._id }
  nick       { |attrs| attrs[:user].nick }
  first_name { |attrs| attrs[:user].profile.first_name }
  last_name  { |attrs| attrs[:user].profile.last_name }
  location   { |attrs| attrs[:user].profile.location }
  images     { |attrs| attrs[:user].profile.images }
end
