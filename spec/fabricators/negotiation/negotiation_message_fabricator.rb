Fabricator(:negotiation_message, class_name: "Negotiation::Message") do
  transient :offer
  negotiation nil
  user_id     { |a| a[:offer].composer._id }
  user_name   { |a| a[:offer].composer.name }
  text        { |a| a[:offer].initial_message }
  image       { |a| a[:offer].composer.image }
end
