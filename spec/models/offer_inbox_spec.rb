require 'spec_helper'

describe OfferInbox do

  describe 'Embedded' do
    it { should be_embedded_in :user }
  end


  describe 'Associated' do
    it { should have_many(:offers).with_autosave }
  end

  describe 'Attributes' do
  end

  describe 'Factory' do
    let (:offer_inbox) { Fabricate(:offer_inbox) }
    specify { offer_inbox.should be_valid }
  end

end
