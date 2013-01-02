Fabricator(:offer) do
  composer        { Fabricate.build(:offer_composer, offer:nil) }
  receiver        { Fabricate.build(:offer_receiver, offer:nil) }
  money           nil
  initial_message 'a long initial message to try the interface with a long text'
end
