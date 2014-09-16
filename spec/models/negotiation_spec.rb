require 'rails_helper'

describe Negotiation do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }

  it { is_expected.to include_module Proposable }
  it { is_expected.to include_module Conversation }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :offer_id}
  it { is_expected.to have_field :signer }
  it { is_expected.to have_field :confirmer }

  #methods
  
  describe '#authorized?(user)' do
    let!(:authorized_policy ) { AuthorizedNegotiationPolicy.new(negotiation) }
    
    it 'calls AuthorizedNegotiationPolicy#authorized?' do
      allow(AuthorizedNegotiationPolicy).to receive(:new) { authorized_policy }
      expect(authorized_policy).to receive(:authorized?).with(composer_id)
      negotiation.authorized? composer_id
    end
  end

  describe '#abandoned?' do
    
    it 'returns true if a user abandoned the negotiation' do
      negotiation.abandon(composer_id)
      expect(negotiation.reload.abandoned?).to eq true
    end

    it 'returns false if no user abandoned the negotiation' do
      expect(negotiation.abandoned?).to eq false
    end
  end

  describe '#negotiable?' do
    let!(:negotiable_policy) { NegotiableNegotiationPolicy.new(negotiation) }
    
    it 'calls NegotiableNegotiation#negotiable?' do
      allow(NegotiableNegotiationPolicy).to receive(:new) { negotiable_policy }
      expect(negotiable_policy).to receive(:negotiable?)
      negotiation.negotiable?
    end
  end

  describe '#can_sign?(user_id)' do
    let!(:sign_policy) { CanSignNegotiationPolicy.new(negotiation) }
    
    it 'calls CanSignNegotiationPolicy#can_sign?' do
      allow(CanSignNegotiationPolicy).to receive(:new) { sign_policy }
      expect(sign_policy).to receive(:can_sign?).with(composer_id)
      negotiation.can_sign?(composer_id)
    end
  end

  describe '#can_unsign?(user_id' do
    let!(:unsign_policy) { CanUnsignNegotiationPolicy.new(negotiation) }
    
    it 'calls CanUnsignNegotiationPolicy#can_unsign?' do
      allow(CanUnsignNegotiationPolicy).to receive(:new) { unsign_policy }  
      negotiation.sign(composer_id)
      expect(unsign_policy).to receive(:can_unsign?).with(composer_id)
      negotiation.can_unsign?(composer_id)
    end
  end

  describe '#can_confirm?(user_id)' do
    let!(:confirm_policy) { CanConfirmNegotiationPolicy.new(negotiation)}
    
    it 'calls CanSignNegotiationPolicy#can_confirm?' do
      allow(CanConfirmNegotiationPolicy).to receive(:new) { confirm_policy }
      expect(confirm_policy).to receive(:can_confirm?).with(composer_id)
      negotiation.can_confirm?(composer_id)
    end
  end

  describe '#abandon(user_id)' do
    let!(:negotiation_user_abandoner) { NegotiationUserAbandoner.new(negotiation) }
    
    it 'calls NegotiationUserAbandoner#abandon' do
      allow(NegotiationUserAbandoner).to receive(:new) { negotiation_user_abandoner }
      expect(negotiation_user_abandoner).to receive(:abandon).with(composer_id)
      negotiation.abandon(composer_id)
    end
  end

  describe '#unsign(user_id)' do
    let!(:negotiation_signer) { NegotiationSigner.new(negotiation) }
    
    it 'calls NegotiationSigner#unsign' do
      allow(NegotiationSigner).to receive(:new) { negotiation_signer }
      negotiation.sign(composer_id)
      expect(negotiation_signer).to receive(:unsign).with(composer_id)
      negotiation.unsign(composer_id)
    end
  end

  describe '#sign(user_id)' do
    let!(:negotiation_signer) { NegotiationSigner.new(negotiation) }
    
    it 'calls NegotiationSigner#sign' do
      allow(NegotiationSigner).to receive(:new) { negotiation_signer }
      expect(negotiation_signer).to receive(:sign).with(composer_id)
      negotiation.sign(composer_id)
    end
  end

  describe '#confirm(user_id)' do
    let!(:negotiation_confirmer) { NegotiationConfirmer.new(negotiation) }
    
    it 'calls NegotiationConfirmer#confirm' do
      allow(NegotiationConfirmer).to receive(:new) { negotiation_confirmer }
      expect(negotiation_confirmer).to receive(:confirm).with(composer_id)
      negotiation.confirm(composer_id)
    end
  end
  
  describe '#propose(proposal)' do
    let!(:negotiation_proposer) { NegotiationProposer.new(negotiation) }
    
    it 'calls NegotiationProposer#propose' do
      allow(NegotiationProposer).to receive(:new) { negotiation_proposer }
      expect(negotiation_proposer).to receive(:propose).with(new_proposal)
      negotiation.propose(new_proposal)
    end
  end

  describe '#post_message(user_id,message)' do
    let!(:message_poster) { MessagePoster.new(negotiation) }
    
    it 'calls MessagePoster#post_message' do
      allow(MessagePoster).to receive(:new) { message_poster }
      expect(message_poster).to receive(:post_message).with(user_id:composer_id,message:'message')
      negotiation.post_message(user_id:user_id,message:'message')
    end
  end

  describe '#cash_owner' do
    it 'returns nil if no cash in goods' do
      expect(negotiation.cash_owner).to eq nil
    end

    it 'returns composer_id if composer owns cash' do
      negotiation=Fabricate(:negotiation,cash: :composer)
      expect(negotiation.cash_owner).to eq negotiation.composer.id
    end

    it 'returns receiver_id if receiver owns cash' do
      negotiation=Fabricate(:negotiation,cash: :receiver)
      expect(negotiation.cash_owner).to eq negotiation.receiver.id
    end
  end
end
