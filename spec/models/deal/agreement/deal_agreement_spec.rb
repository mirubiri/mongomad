require 'spec_helper'

describe Deal::Agreement do
  let(:agreement) do
    Fabricate.build(:deal).agreement
  end

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many(:proposals).of_type(Deal::Agreement::Proposal) }
    it { should embed_one(:conversation).of_type(Deal::Agreement::Conversation) }
  end

  describe 'Validations' do
    it { should validate_presence_of :deal }
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :conversation }
  end

  describe 'Factories' do
    specify { expect(agreement).to be_valid }

    it 'creates one deal' do
      expect { agreement.save }.to change{ Deal.count }.by(1)
    end
  end
end
