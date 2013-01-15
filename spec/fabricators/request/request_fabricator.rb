Fabricator(:request) do
  transient :user
  user      { Fabricate(:user) }
  user_id   { |attrs| attrs[:user]._id }
  user_name { |attrs| attrs[:user].profile.name }
  text      'this is a request\'s text. it\'s a long text and it\'s more than one line long to try our beautiful interface.'
  image     { |attrs| attrs[:user].profile.image.url }
end
