require 'spec_helper'

describe Deal::Agreement::Proposal do
  let(:proposal) do
    Fabricate.build(:deal).agreement.proposals[0]
  end

  describe 'Relations' do
    it { should be_embedded_in(:agreement).of_type(Deal::Agreement) }
    it { should embed_one(:composer).of_type(Deal::Agreement::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Deal::Agreement::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Deal::Agreement::Proposal::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
  end

  describe 'Factories' do
    specify { expect(proposal.valid?).to be_true }
  end
end
