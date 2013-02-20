require 'spec_helper'

describe Negotiation::Proposal do
  let(:proposal) do
    Fabricate.build(:negotiation).proposals.last
  end

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_one(:composer).of_type(Negotiation::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Negotiation::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Negotiation::Proposal::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_composer_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_receiver_id).of_type(Moped::BSON::ObjectId) }
  end

  describe 'Validations' do
    it { should validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer_id }
    it { should validate_presence_of :user_receiver_id }
  end

  describe 'Factories' do
    specify { expect(proposal.valid?).to eq true }

    it 'creates one negotiation' do
      expect { proposal.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '.generate(proposal_params=[])' do
    xit 'creates a proposal with the given params'
  end

  describe '#publish' do
    xit 'saves the deal'
  end
end
