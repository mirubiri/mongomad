Fabricator(:negotiation_message, class_name: "Negotiation::Message") do
  transient   :offer
  negotiation nil
  user_id     { |attrs| attrs[:offer].composer._id }
  user_name   { |attrs| attrs[:offer].composer.name }
  text        { |attrs| attrs[:offer].initial_message }
  image       { |attrs| attrs[:offer].composer.image }
end
