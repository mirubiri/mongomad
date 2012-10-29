require 'spec_helper'

describe Deal do
  describe 'Relations' do
    it { should embed_one(:agreement) }
    it { should embed_many(:messages) }
  end

  describe 'Factory' do
    let (:deal) { Fabricate(:deal) }
    specify { deal.should be_valid }
  end
end
