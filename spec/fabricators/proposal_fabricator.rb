Fabricator(:proposal) do
  composer_id { Faker::Code.isbn }
  receiver_id { Faker::Code.isbn }
  goods do |attrs| 
    [ 
      Fabricate.build(:product,user_id:attrs[:composer_id]), 
      Fabricate.build(:product,user_id:attrs[:receiver_id])
    ]
  end
end