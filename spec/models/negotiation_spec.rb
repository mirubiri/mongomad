require 'rails_helper'

describe Negotiation do
  let(:negotiation) { Fabricate(:offer).negotiate }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }
  let!(:ncourse) { NegotiationCourse.new(negotiation) }
  let!(:negotiable_policy) { NegotiableNegotiationPolicy.new(negotiation) }
  let!(:sign_policy) { CanSignNegotiationPolicy.new(negotiation) }
  let!(:confirm_policy) { CanConfirmNegotiationPolicy.new(negotiation)}
  it { is_expected.to include_module Proposable }
  it { is_expected.to include_module Conversation }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :offer_id}
  it { is_expected.to have_field :signer }

  #methods
  
  before(:example) do 
    allow(NegotiationCourse).to receive(:new) { ncourse }
    allow(NegotiableNegotiationPolicy).to receive(:new) { negotiable_policy }
    allow(CanSignNegotiationPolicy).to receive(:new) { sign_policy }
    allow(CanConfirmNegotiationPolicy).to receive(:new) { confirm_policy}
  end

  describe '#negotiable?' do
    it 'calls NegotiationCourse#negotiable?' do
      expect(negotiable_policy).to receive(:negotiable?)
      negotiation.negotiable?
    end
  end

  describe '#can_sign?(user_id)' do
    it 'calls CanSignNegotiationPolicy#can_sign?' do
      expect(sign_policy).to receive(:can_sign?).with(composer_id)
      negotiation.can_sign?(composer_id)
    end
  end

  describe '#can_confirm?(user_id)' do
    it 'calls CanSignNegotiationPolicy#can_confirm?' do
      expect(confirm_policy).to receive(:can_confirm?).with(composer_id)
      negotiation.can_confirm?(composer_id)
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

  describe '#confirm' do
    it 'calls NegotiationCourse#confirm' do
      expect(ncourse).to receive(:confirm).with(receiver_id)
      negotiation.confirm(receiver_id)
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
