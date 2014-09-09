Fabricator(:proposal) do
  transient :cash
  composer_id { Faker::Code.isbn }
  receiver_id { Faker::Code.isbn }
  goods do |attrs| 
    case attrs[:cash]
    when nil
      [ 
        Fabricate.build(:product,user_id:attrs[:composer_id]), 
        Fabricate.build(:product,user_id:attrs[:receiver_id])
      ]
    when :composer
      [ 
        Fabricate.build(:cash,user_id:attrs[:composer_id]), 
        Fabricate.build(:product,user_id:attrs[:receiver_id])
      ]
    when :receiver
      [ 
        Fabricate.build(:product,user_id:attrs[:composer_id]), 
        Fabricate.build(:cash,user_id:attrs[:receiver_id])
      ]
    end

  end
end