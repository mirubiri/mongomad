shared_context "clean collections" do
  after(:each) do
    Offer.all.destroy
    Negotiation.all.destroy
    User.all.destroy
    Deal.all.destroy
    Request.all.destroy
  end
end