require 'spec_helper'

describe Negotiation do
  describe 'Relations' do
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Factory' do
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
  end
end
