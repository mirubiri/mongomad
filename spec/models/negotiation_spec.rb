require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.proposals.last.composer_id }
  let(:receiver_id) { negotiation.proposals.last.receiver_id }

  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
  it { should_not embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:state) }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should_not validate_presence_of :messages }
  it { should validate_presence_of :state }

  # Methods
  describe '#proposal' do
    it 'returns the last proposal' do
      negotiation.proposals.build
      expect(negotiation.proposal).to eq negotiation.proposals.last
    end
  end

  describe '#composer' do
    it 'calls proposal.composer_id' do
      expect(negotiation.proposal).to receive(:composer_id)
      negotiation.composer
    end
  end

  describe '#receiver' do
    it 'calls proposal.receiver_id' do
      expect(negotiation.proposal).to receive(:receiver_id)
      negotiation.receiver
    end
  end
  
  describe '#statemachine' do
  end
  # Factories
  specify { expect(negotiation).to be_valid }
end