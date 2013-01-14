Fabricator(:negotiation_message, class_name: "Negotiation::Message") do
  transient   :user
  negotiation nil
  user_id     { |attrs| attrs[:user]._id }
  user_name   { |attrs| attrs[:user].profile.name }
  text        'this is the first negotiation\'s message. it\'s written by the composer when he responds an offer.'
  image       { |attrs| attrs[:user].profile.image.url }
end
