Fabricator(:user) do
  after_build do |user|
    user.profile=Fabricate(:profile,user: user)
    user.thing_box=Fabricate(:thing_box,user: user)
    user.deal_box=Fabricate(:deal_box,user: user)
    user.negotiation_box=Fabricate(:negotiation_box,user: user)
    user.offer_inbox=Fabricate(:offer_inbox,user: user)
    user.offer_outbox=Fabricate(:offer_outbox,user: user)
  end
end