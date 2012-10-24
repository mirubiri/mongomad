require 'spec_helper'

describe OfferOutbox do

  describe 'Embedded' do
    it { should be_embedded_in :user }
  end

  describe 'Associated' do
    it { should have_many(:offers).with_autosave }
  end

  describe 'Attributes' do
  end

  describe 'Factory' do
    let (:offer_outbox) { Fabricate(:offer_outbox) }
    specify { offer_outbox.should be_valid }
  end
end
