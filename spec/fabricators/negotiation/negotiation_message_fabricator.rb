Fabricator(:negotiation_message, class_name: "Negotiation::Message") do
  transient   :composer
  negotiation nil
  user_id     { |attrs| attrs[:composer].user_id }
  user_name   { |attrs| attrs[:composer].name }
  text        'this is the first negotiation\'s message. it\'s written by the composer when he responds an offer.'
  image       { |attrs| attrs[:composer].image }
end
