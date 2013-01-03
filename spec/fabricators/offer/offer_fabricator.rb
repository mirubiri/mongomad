Fabricator(:offer) do
  composer        { Fabricate(:offer_composer, offer:nil,user_id:Fabricate(:user)._id) }
  receiver        { Fabricate(:offer_receiver, offer:nil,user_id:Fabricate(:user)._id) }
  money           nil
  initial_message 'a long initial message to try the interface with a long text'
end
