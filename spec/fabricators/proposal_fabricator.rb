Fabricator(:proposal) do
  transient :sender,:receiver
  sender { Fabricate(:user_with_items) }
  receiver { Fabricate(:user_with_items) }

  products do |attrs|
    sender_item=attrs[:sender].items.sample
    receiver_item=attrs[:receiver].items.sample

    [Fabricate.build(:product,item:sender_item),Fabricate.build(:product,item:receiver_item)]
  end
end