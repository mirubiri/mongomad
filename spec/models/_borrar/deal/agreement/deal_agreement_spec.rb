require 'spec_helper'

describe Deal::Agreement do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_one(:conversation).of_type(Deal::Agreement::Conversation) }
    it { should embed_many(:proposals).of_type(Deal::Agreement::Proposal) }
  end

  describe 'Attributes' do
    it { should accept_nested_attributes_for :conversation }
    it { should accept_nested_attributes_for :proposals }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :deal }
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :proposals }
  end

  describe 'Factories' do
    specify { expect(agreement).to be_valid }

    it 'creates one deal' do
      expect { agreement.save }.to change{ Deal.count }.by(1)
    end
  end
end
