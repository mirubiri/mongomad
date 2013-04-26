require 'spec_helper'

describe Negotiation::Proposal do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:composer) { proposal.user_composer }
  let(:receiver) { proposal.user_receiver }

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
    it { should accept_nested_attributes_for :composer }
    it { should accept_nested_attributes_for :receiver }
    it { should accept_nested_attributes_for :money }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer_id }
    it { should validate_presence_of :user_receiver_id }
  end

  describe 'Factories' do
    specify { expect(proposal).to be_valid }

    it 'creates one negotiation' do
      expect { proposal.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#user_composer' do
    let(:user_composer_id) { proposal.user_composer_id }
    let(:negotiation_composer) { proposal.negotiation.negotiators.find(user_composer_id) }

    context 'When proposal has no negotiation assigned' do
      it 'returns nil' do
        proposal.negotiation = nil
        expect(proposal.user_composer).to eq nil
      end
    end

    context 'When proposal has a negotiation assigned' do
      it 'returns the user of the negotiation who made the proposal' do
        expect(proposal.user_composer).to eq negotiation_composer
      end
    end
  end

  describe '#user_composer' do
    let(:user_receiver_id) { proposal.user_receiver_id }
    let(:negotiation_receiver) { proposal.negotiation.negotiators.find(user_receiver_id) }

    context 'When proposal has no negotiation assigned' do
      it 'returns nil' do
        proposal.negotiation = nil
        expect(proposal.user_receiver).to eq nil
      end
    end

    context 'When proposal has a negotiation assigned' do
      it 'returns the user of the negotiation who received the proposal' do
        expect(proposal.user_receiver).to eq negotiation_receiver
      end
    end
  end

=begin
  describe '#propose' do
    xit 'initializes token'
  end
=end

  describe '#can_cancel?(negotiator)' do
    context 'When the given negotiator is the composer of the current proposal' do
      it 'returns true' do
        expect(proposal.can_cancel?(composer)).should be_true
      end
    end

    context 'When the given negotiator is the receiver of the current proposal' do
      it 'returns false' do
        expect(proposal.can_cancel?(receiver)).should be_false
      end
    end
  end

=begin
  describe '#cancel' do
  end
=end


  describe '#can_reject?(negotiator)' do
    context 'When given negotiator is the composer of the current proposal' do
      it 'returns false' do
        expect(proposal.can_reject?(composer)).should be_false
      end
    end

    context 'When given negotiator is the receiver of the current proposal' do
      it 'returns true' do
        expect(proposal.can_reject?(receiver)).should be_true
      end
    end
  end

=begin
  describe '#reject' do
  end
=end

  describe '#can_sign?(negotiator)' do
    context 'When given negotiator is the composer of the current proposal' do
      it 'returns false' do
        expect(proposal.can_sign?(composer)).should be_false
      end
    end

    context 'When given negotiator is the receiver of the current proposal' do
      it 'returns true' do
        expect(proposal.can_sign?(receiver)).should be_true
      end
    end
  end

=begin
  describe '#sign' do
  end
=end

  describe '#can_confirm?(negotiator)' do
    context 'When given negotiator is the composer of the current proposal' do
      it 'returns false' do
        expect(proposal.can_sign?(composer)).should be_false
      end
    end

    context 'When given negotiator is the receiver of the current proposal' do
      it 'returns true' do
        expect(proposal.can_sign?(receiver)).should be_true
      end
    end
  end

=begin
  describe '#confirm' do
  end

  describe '#kick(negotiator)' do
  end
=end
end
