require 'spec_helper'

describe Deal::Agreement do
  #let(:negotiation) { Fabricate.build(:negotiation) }
  #after(:each) { negotiation && negotiation.destroy }

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many(:proposals).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:messages).of_type(Deal::Agreement::Message) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
  end

=begin
  describe 'Factories' do
    specify { negotiation.should be_valid }
    specify { negotiation.save.should be_true }
  end
=end
end