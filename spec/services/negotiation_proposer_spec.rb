require 'rails_helper'

describe NegotiationProposer do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.composer.id }
  let(:receiver_id) { negotiation.receiver.id }
  let(:proposal) { Fabricate.build(:proposal,composer_id:composer_id,receiver_id:receiver_id) }
  let(:proposer) { NegotiationProposer.new(negotiation) }

  shared_examples 'cannot propose' do
      it 'returns false' do
        expect(proposer.propose(proposal)).to eq false
      end

      it 'does not change the current proposal' do
        expect{proposer.propose(proposal)}.not_to change{ negotiation.proposal }
      end

      it 'does not reset the negotiation course' do
        expect(negotiation).not_to receive(:reset_course)
      end
  end

  describe '#propose(proposal)' do
    context 'negotition is not negotiable' do
      before(:example) { allow(negotiation).to receive(:negotiable?) { false }}
      include_examples 'cannot propose'
    end
    
    context 'a participant in the given proposal is not in the negotiation' do
      before(:example) { proposal.composer_id='non_participant_id' }
      include_examples 'cannot propose'
    end

    context 'participants of the proposal belongs to the negotiation' do
      it 'returns true' do
        expect(proposer.propose(proposal)).to eq true
      end

      it 'change the current proposal to the given proposal' do
        expect{ proposer.propose(proposal) }.to change { negotiation.proposal }.to proposal
      end

      it 'resets the negotiation course' do
        expect(negotiation).to receive(:reset_course)
        proposer.propose(proposal) 
      end
    end
  end  
end
