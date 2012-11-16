require 'spec_helper'

describe Agreement do
  let(:agreement) { Fabricate(:agreement) }

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Validations' do
    it { should validate_presence_of :deal }
    it { should validate_presence_of :proposals }
  end

  describe 'Factory' do
    specify { agreement.should be_valid }
    specify { agreement.save.should be_true }
  end
end