require 'spec_helper'

class Test::Proposable 
  include Proposable
  proposal_historic :false
end

class Test::ProposableHistoric
  include Proposable
  proposal_historic :true
end

describe 'Proposable' do
  let(:proposable) { Test::Proposable.new }
  let(:historic_proposable) { Test::ProposableHistoric.new }

  subject { Test::Proposable }
  it { should < Ownership::Dual }

  context 'proposal_historic is :false' do
    it { should embed_one(:proposal).of_type(Proposal) }
  end

  context 'proposal_historic is true' do
    subject { Test::ProposableHistoric }
    it { should embed_many(:proposals).of_type(Proposal) }

    describe '#proposal' do
      it 'returns the last proposal' do
        historic_proposable.proposals.build
        last_proposal=historic_proposable.proposals.build
        expect(historic_proposable.proposal).to eq last_proposal
      end
    end
  end
end 
