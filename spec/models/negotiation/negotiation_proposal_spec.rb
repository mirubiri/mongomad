require 'spec_helper'

describe Negotiation::Proposal do
  let(:proposal) { Fabricate.build(:negotiation).proposals[0] }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_one(:composer).of_type(Negotiation::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Negotiation::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Negotiation::Proposal::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
  end

  describe 'Factories' do
    specify { expect(proposal.valid?).to be_true }
    specify { expect(proposal.save).to be_true }
  end
end
