Fabricator(:negotiation_message, class_name: "Negotiation::Message") do
  transient   :offer
  negotiation nil
  user_id     { |attrs| attrs[:offer].composer.user_id }
  user_name   { |attrs| attrs[:offer].composer.name }
  text        'this is the first negotiation\'s message. it\'s written by the composer when he responds an offer.'
  image       { |attrs| attrs[:offer].composer.image }
end
