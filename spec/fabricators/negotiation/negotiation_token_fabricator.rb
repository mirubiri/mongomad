Fabricator(:negotiation_token, class_name: 'Negotiation::Token') do
  transient   :user
  negotiation nil
  user_id     { |attrs| attrs[:user].id }
  state       :propose
end
