require 'spec_helper'

describe DealBox do
  describe 'Embedded' do
    it { should be_embedded_in :user }
  end

  describe 'Associated' do
    it { should have_many(:deals).with_autosave }
  end

  describe 'Attributes' do
  end

  describe 'Factory' do
    let (:deal_box) { Fabricate(:deal_box) }
    specify { deal_box.should be_valid }
  end
end
