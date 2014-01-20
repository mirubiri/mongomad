Fabricator(:negotiation) do
  transient   :offer
  offer       { Fabricate(:offer) }
  users       { |attrs| [ attrs[:offer].user_composer, attrs[:offer].user_receiver ] }
  user_sheets { |attrs| [ Fabricate.build(:user_sheet, user:attrs[:user_composer]), Fabricate.build(:user_sheet, user:attrs[:user_receiver]) ] }
  proposals   { |attrs| [ attrs[:offer].proposal ] }
  messages    { |attrs| [ Fabricate.build(:message, text:attrs[:offer].message) ] }
end
