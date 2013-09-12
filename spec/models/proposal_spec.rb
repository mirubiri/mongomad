require 'spec_helper'

describe Proposal do
  let(:proposal) { Fabricate.build(:proposal) }
  # let(:offer) { Fabricate(:offer) }
  # let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  # let(:proposal) { negotiation.proposals.last }
  # let(:negotiation_composer) { negotiation.negotiators.find(proposal.user_composer_id) }
  # let(:negotiation_receiver) { negotiation.negotiators.find(proposal.user_receiver_id) }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }
  it 'should validate presence of products for both sides'

  #Methods
  describe 'left(user:id)' do
    it 'returns products for the left side' do
      owner_id = proposal.goods.first.owner_id
      expect(proposal.goods).to receive(:where).with(owner_id:owner_id)
      proposal.left(owner_id)
    end
  end

  describe 'right(user:id)' do
    it 'return products for the right side' do
      owner_id = proposal.goods.first.owner_id
      expect(proposal.goods).to receive(:where).with(:owner_id.ne =>owner_id)
      proposal.right(owner_id)
    end
  end

  describe '#bucks?' do
    it 'calls assets.type(Bucks) with any' do
      expect(proposal.goods.type(Bucks)).to receive(:any?)
      proposal.bucks?
    end

    it 'returns true if bucks in proposal' do
      proposal.goods.build({},Bucks)
      expect(proposal.bucks?).to eq true
    end

    it 'returns false if no bucks in proposal' do
      expect(proposal.bucks?).to eq false
    end
  end

  # Factories
  specify { expect(Fabricate.build(:proposal)).to be_valid }

  #   it 'creates one negotiation' do
  #     expect { proposal.save }.to change{ Negotiation.count }.by(1)
  #   end

  # describe '#user_composer' do
  #   context 'When proposal has no negotiation assigned' do
  #     it 'returns nil' do
  #       proposal.negotiation = nil
  #       expect(proposal.user_composer).to eq nil
  #     end
  #   end

  #   context 'When proposal has a negotiation assigned' do
  #     it 'returns the user of the negotiation who made the proposal' do
  #       expect(proposal.user_composer).to eq negotiation_composer
  #     end
  #   end
  # end

  # describe '#user_receiver' do
  #   context 'When proposal has no negotiation assigned' do
  #     it 'returns nil' do
  #       proposal.negotiation = nil
  #       expect(proposal.user_receiver).to eq nil
  #     end
  #   end

  #   context 'When proposal has a negotiation assigned' do
  #     it 'returns the user of the negotiation who received the proposal' do
  #       expect(proposal.user_receiver).to eq negotiation_receiver
  #     end
  #   end
  # end

  # describe '#state' do
  #   before { proposal.save }

  #   it 'initial state is :unsigned when composer has money' do
  #     offer = Fabricate(:offer_composer_money)
  #     expect(offer.start_negotiation.proposals.last.state).to eq 'unsigned'
  #   end

  #   it 'initial state is :composer_signed when composer has no money' do
  #     expect(proposal.state).to eq 'composer_signed'
  #   end

  #   context 'When proposal is in :unsigned state' do
  #     before { proposal.state = :unsigned }

  #     it 'change from :unsigned to :receiver_signed on :sign_receiver event' do
  #       proposal.sign_receiver
  #       expect(proposal.state).to eq 'receiver_signed'
  #     end

  #     it 'change from :unsigned to :composer_canceled on :cancel_composer event' do
  #       proposal.cancel_composer
  #       expect(proposal.state).to eq 'composer_canceled'
  #     end

  #     it 'change from :unsigned to :receiver_canceled on :cancel_receiver event' do
  #       proposal.cancel_receiver
  #       expect(proposal.state).to eq 'receiver_canceled'
  #     end
  #   end

  #   context 'When proposal is in :composer_signed state' do
  #     before { proposal.state = :composer_signed }

  #     it 'change from :composer_signed to :receiver_confirmed on :confirm_receiver event' do
  #       proposal.confirm_receiver
  #       expect(proposal.state).to eq 'receiver_confirmed'
  #     end

  #     it 'change from :composer_signed to :composer_canceled on :cancel_composer event' do
  #       proposal.cancel_composer
  #       expect(proposal.state).to eq 'composer_canceled'
  #     end

  #     it 'change from :composer_signed to :receiver_canceled on :cancel_receiver event' do
  #       proposal.cancel_receiver
  #       expect(proposal.state).to eq 'receiver_canceled'
  #     end
  #   end

  #   context 'When proposal is in :receiver_signed state' do
  #     before { proposal.state = :receiver_signed }

  #     it 'change from :receiver_signed to :composer_confirmed on :confirm_composer event' do
  #       proposal.confirm_composer
  #       expect(proposal.state).to eq 'composer_confirmed'
  #     end

  #     it 'change from :receiver_signed to :composer_canceled on :cancel_composer event' do
  #       proposal.cancel_composer
  #       expect(proposal.state).to eq 'composer_canceled'
  #     end

  #     it 'change from :receiver_signed to :receiver_canceled on :cancel_receiver event' do
  #       proposal.cancel_receiver
  #       expect(proposal.state).to eq 'receiver_canceled'
  #     end
  #   end
  # end
end
