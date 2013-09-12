Fabricator(:proposal) do
  transient :composer,:receiver
  composer   { Fabricate(:user_with_items) }
  receiver { Fabricate(:user_with_items) }

  composer_id   { |attrs| attrs[:composer].id }
  receiver_id { |attrs| attrs[:receiver].id }

  proposal_container { |attrs| Fabricate.build(:offer,proposal:nil,user_composer:attrs[:composer],user_receiver:attrs[:receiver]) }

  assets do |attrs|
    composer_item=attrs[:composer].items.sample
    receiver_item=attrs[:receiver].items.sample

    [Fabricate.build(:product,item:composer_item,proposal:nil),Fabricate.build(:product,item:receiver_item,proposal:nil)]
  end
end