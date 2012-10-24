require 'spec_helper'

describe NegotiationBox do
  describe 'Embedded' do
    it { should be_embedded_in :user }
  end

  describe 'Associated' do
    it { should have_many(:negotiations).with_autosave }
  end

  describe 'Attributes' do
  end

  describe 'Factory' do
    let (:negotiation_box) { Fabricate(:negotiation_box) }
    specify { negotiation_box.should be_valid }
  end
end
