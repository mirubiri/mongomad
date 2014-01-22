Fabricator(:negotiation) do
  transient   :offer
  offer       { Fabricate(:offer) }
  users       { |attrs| [ attrs[:offer].user_composer, attrs[:offer].user_receiver ] }
  user_sheets { |attrs| [ Fabricate.build(:user_sheet, user:attrs[:users].first), Fabricate.build(:user_sheet, user:attrs[:users].last) ] }
  proposals   { |attrs| [ attrs[:offer].proposal ] }
  messages    { |attrs| [ Fabricate.build(:message, text:attrs[:offer].message) ] }
end
