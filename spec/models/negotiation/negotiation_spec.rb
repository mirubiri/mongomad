require 'spec_helper'

describe Negotiation do
  let(:negotiation) do
    Fabricate(:negotiation)
  end

  describe 'Relations' do
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
    it { should embed_many(:messages).of_type(Negotiation::Message) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
  end

  describe 'Factories' do
    specify { expect(negotiation.valid?).to be_true }
    specify { expect(negotiation.save).to be_true }
  end
end
