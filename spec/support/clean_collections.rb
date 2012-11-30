shared_context "clean collections" do
  after(:each) do
    User.all.destroy
    Request.all.destroy
    Offer.all.destroy
    Negotiation.all.destroy
    Deal.all.destroy
  end
end