Fabricator(:request) do
  user          { Fabricate.build(:user) }
  user_name { |attrs| attrs[:user].profile.nickname }
  text          'this is a request\'s text. it\'s a long text and it\'s more than one line long to try our beautiful interface.'
  image         { |attrs| File.open(attrs[:user].profile.image.path) }
end
