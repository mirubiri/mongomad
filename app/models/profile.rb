class Profile
  include Mongoid::Document
  embedded_in :user
end
