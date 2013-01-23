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
    it { should have_field(:user_composer).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_receiver).of_type(Moped::BSON::ObjectId) }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer }
    it { should validate_presence_of :user_receiver }
  end

  describe 'Factories' do
    specify { expect(proposal.valid?).to be_true }
    it 'Creates one negotiation' do
      expect { proposal.save }.to change{ Negotiation.count}.by(1)
    end
  end
end
