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
    it { should have_field(:user_composer).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_receiver).of_type(Moped::BSON::ObjectId) }
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
  end

  describe 'Factories' do
    specify { expect(proposal.valid?).to be_true }
    it 'Creates one negotiation' do
      expect { proposal.save }.to change{ Negotiation.count}.by(1)
    end
    it 'Creates one offer' do
      expect { proposal.save }.to change{ Offer.count}.by(1)
    end
    it 'Creates two users' do
      expect { proposal.save }.to change{ User.count }.by(2)
    end
  end
end
