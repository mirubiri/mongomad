require 'rails_helper'

describe Negotiation do
  let(:negotiation) { Fabricate(:offer).negotiate }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }
  let!(:ncourse) { NegotiationCourse.new(negotiation) }

  it { is_expected.to include_module Proposable }
  it { is_expected.to include_module Conversation }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :offer_id}
  it { is_expected.to have_field :signer }

  #methods
  
  before(:example) { allow(NegotiationCourse).to receive(:new) { ncourse } }
  
  describe '#negotiating?' do
    it 'returns false if one user left' do
      negotiation.leave(composer_id)
      expect(negotiation).not_to be_negotiating
    end

    it 'returns true if both users in' do
      expect(negotiation).to be_negotiating
    end
  end

  describe '#leave' do
    it 'calls NegotiationCourse#leave' do
      expect(ncourse).to receive(:leave).with(composer_id)
      negotiation.leave(composer_id)
    end
  end

  describe '#sign' do
    it 'calls NegotiationCourse#sign' do
      expect(ncourse).to receive(:sign).with(composer_id)
      negotiation.sign(composer_id)
    end
  end

  describe '#cash_owner' do
    it 'returns nil if no cash in goods' do
      expect(negotiation.cash_owner).to eq nil
    end

    it 'returns composer_id if composer owns cash' do
      negotiation=Fabricate(:offer,cash: :composer).negotiate
      expect(negotiation.cash_owner).to eq negotiation.composer.id
    end

    it 'returns receiver_id if receiver owns cash' do
      negotiation=Fabricate(:offer,cash: :receiver).negotiate
      expect(negotiation.cash_owner).to eq negotiation.receiver.id
    end
  end
end
