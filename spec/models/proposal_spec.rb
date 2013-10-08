require 'spec_helper'

describe Proposal do
  let(:proposal) { Fabricate.build(:proposal) }

  # Relations
  it { should be_embedded_in :proposal_container }
  it { should embed_many :goods }
  it { should embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should_not validate_presence_of :proposal_container }
  it { should validate_presence_of :composer_id }
  it { should validate_presence_of :receiver_id }

  it 'is invalid when there is not a good for composer' do
    composer_id=proposal.composer_id
    proposal.goods.delete_all(owner_id:composer_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when there is not a good for receiver' do
    receiver_id=proposal.receiver_id
    proposal.goods.delete_all(owner_id:receiver_id)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid when is more than one cash in goods' do
    2.times { proposal.goods.build({},Cash) }
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid if a good is not owned by composer or receiver' do
    proposal.goods.sample.owner_id=Faker::Number.number(26)
    expect(proposal).to have(1).error_on(:goods)
  end

  it 'is invalid if a good is duplicated' do
    good=proposal.goods.sample
    proposal.goods << good
    expect(proposal).to have(1).error_on(:goods)
  end


  it 'is invalid when there is not a sheet for composer_id' do
    offer.composer_id=nil
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid when there is not a sheet for receiver_id' do
    offer.receiver_id=nil
    expect(proposal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there are more than two user sheets' do
    proposal.user_sheets << offer.user_sheets.first
    expect(proposal).to have(1).error_on(:user_sheets)
  end


  #Methods
  describe 'left(user:id)' do
    it 'returns products for the left side' do
      owner_id = proposal.goods.sample.owner_id
      expect(proposal.goods).to receive(:where).with(owner_id:owner_id)
      proposal.left(owner_id)
    end
  end

  describe 'right(user:id)' do
    it 'return products for the right side' do
      owner_id = proposal.goods.sample.owner_id
      expect(proposal.goods).to receive(:where).with(:owner_id.ne =>owner_id)
      proposal.right(owner_id)
    end
  end

  describe '#cash?' do
    it 'calls goods.type(Cash) with any' do
      expect(proposal.goods.type(Cash)).to receive(:exists?)
      proposal.cash?
    end

    it 'returns true if cash in proposal' do
      proposal.goods.build({},Cash)
      expect(proposal.cash?).to eq true
    end

    it 'returns false if no cash in proposal' do
      expect(proposal.cash?).to eq false
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
