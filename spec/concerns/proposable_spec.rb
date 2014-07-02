require 'rails_helper'

class TestProposable
  include Mongoid::Document
  include Proposable
  proposal_historic :false
end

class TestProposableHistoric
  include Mongoid::Document
  include Proposable
  proposal_historic :true
end

describe 'Proposable', type: :model do
  let(:proposable) { TestProposable.new }
  let(:historic_proposable) { TestProposableHistoric.new }
  let(:composer) { Fabricate.build(:user) }
  let(:receiver) { Fabricate.build(:user) }
  let(:goods) do
    [ Fabricate.build(:item,user_id:composer.id).to_product,
      Fabricate.build(:item,user_id:receiver.id).to_product,
      Fabricate.build(:cash,user_id:composer).to_product ]
  end

  subject { TestProposable }
  it { is_expected.to be < Ownership }

  context 'proposal_historic is :false' do
    it { is_expected.to embed_one(:proposal).of_type(Proposal) }
  end

  context 'proposal_historic is true' do
    subject { TestProposableHistoric }
    it { is_expected.to embed_many(:proposals).of_type(Proposal) }

    describe '#proposal' do
      it 'returns the last proposal' do
        historic_proposable.proposals.build
        last_proposal=historic_proposable.proposals.build
        expect(historic_proposable.proposal).to eq last_proposal
      end
    end
  end

  before(:example) do
    proposable.build_proposal(composer_id:composer.id,receiver_id:receiver.id,goods:goods)
    proposable.user_ids=[composer.id,receiver.id]
    proposable.user_sheets=[composer.sheet,receiver.sheet]
  end

  describe '#composer' do
    it 'returns the user_sheet of the composer' do
      expect(proposable.composer).to eq composer.sheet
    end
  end

  describe '#receiver' do
    it 'returns the user_sheet of the receiver' do
      expect(proposable.receiver).to eq receiver.sheet
    end
  end

  describe '#goods' do
    it 'returns all users goods' do
      expect(proposable.goods).to eq proposable.proposal.goods
    end
  end

  describe '#composer_goods' do
    it 'returns composer goods' do
      expect(proposable.composer_goods).to eq proposable.proposal.composer_goods
    end
  end

  describe '#receiver_goods' do
    it 'return receiver goods' do
      expect(proposable.receiver_goods).to eq proposable.proposal.receiver_goods
    end
  end
end
