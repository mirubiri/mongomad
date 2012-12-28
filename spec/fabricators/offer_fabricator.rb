Fabricator(:offer) do
  composer        { Fabricate.build(:offer_composer) }
  receiver        { Fabricate.build(:offer_receiver) }
  money           nil
  initial_message 'a long initial message to try the interface with a long text'
end
