require 'spec_helper'

describe Agreement do
  describe 'Relations' do
    it { should embedded_in (:deal) }
    it { should embed_many(:proposals) }
    it { should embed_many(:messages) }
  end

  describe 'Factory' do
    let (:agreement) { Fabricate(:agreement) }
    specify { agreement.should be_valid }
  end
end