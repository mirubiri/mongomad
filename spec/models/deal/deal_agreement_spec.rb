require 'spec_helper'

describe Deal::Agreement do
  let(:agreement) do
    Fabricate.build(:deal).agreement
  end

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many(:proposals).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:messages).of_type(Deal::Agreement::Message) }
  end

  describe 'Validations' do
    it { should validate_presence_of :deal }
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
  end

  describe 'Factories' do
    specify { expect(agreement.valid?).to eq true, "Is not valid because #{agreement.errors}" }

    it 'creates one deal' do
      expect { agreement.save }.to change{ Deal.count }.by(1)
    end
  end
end
