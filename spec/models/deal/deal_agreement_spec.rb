require 'spec_helper'

describe Deal::Agreement do
  let(:agreement) { Fabricate.build(:deal).agreement }

  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many(:proposals).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:messages).of_type(Deal::Agreement::Message) }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
  end

  describe 'Factories' do
    specify { expect(agreement.valid?).to be_true }
  end
end
