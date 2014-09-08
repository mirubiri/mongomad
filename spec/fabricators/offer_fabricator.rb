Fabricator(:offer) do
  transient :composer_id
  transient :receiver_id
  composer_id { Faker::Code.isbn }
  receiver_id { Faker::Code.isbn }
  user_ids { |attrs| [ attrs[:composer_id],attrs[:receiver_id] ] }
  user_sheets do |attrs| 
    [
      Fabricate.build(:user_sheet,id:attrs[:composer_id]),
      Fabricate.build(:user_sheet,id:attrs[:receiver_id])
    ]
  end
  proposal do |attrs| 
    Fabricate.build(:proposal,composer_id:attrs[:composer_id],receiver_id:attrs[:receiver_id])
  end
  message { |attrs| Fabricate.build(:message,user_id:attrs[:composer_id])}
end