Fabricator(:offer) do
  composer        { Fabricate.build(:offer_composer) }
  receiver        { Fabricate.build(:offer_receiver) }
  money           { Fabricate.build(:offer_money) }
  initial_message 'a long initial message to try the interface with a long text'
end
