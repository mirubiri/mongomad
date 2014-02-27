require 'spec_helper'

describe Negotiation do
  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:composer_id) { negotiation.proposal.composer_id }
  let(:receiver_id) { negotiation.proposal.receiver_id }

  let(:negotiation_composer_cash) do
    negotiation.proposal.goods << Fabricate.build(:cash, owner_id:composer_id)
    negotiation
  end

  let(:negotiation_receiver_cash) do
    negotiation.proposal.goods << Fabricate.build(:cash, owner_id:receiver_id)
    negotiation
  end

  # Relations
  it { should have_and_belong_to_many :users }
  it { should have_one :offer }
  it { should embed_many :user_sheets }
  it { should embed_many :proposals }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:absent_user).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should validate_presence_of :users }
  it { should_not validate_presence_of :offer }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should_not validate_presence_of :adsent_user }

  # Checks
  it 'is invalid if there are more than two users' do
    negotiation.users << Fabricate.build(:user)
    expect(negotiation).to have(1).error_on(:users)
    expect(negotiation.errors_on(:users)).to include('Negotiation should have only two users.')
  end

  it 'is invalid if both users are the same' do
    negotiation.users[1]._id = negotiation.users[0]._id
    expect(negotiation).to have(1).error_on(:users)
    expect(negotiation.errors_on(:users)).to include('Negotiation users should not be equal.')
  end

  it 'is invalid if there are more than two user sheets' do
    negotiation.user_sheets << Fabricate.build(:user_sheet)
    expect(negotiation).to have(1).error_on(:user_sheets)
    expect(negotiation.errors_on(:user_sheets)).to include('Negotiation should have only two user_sheets.')
  end

  it 'is invalid if there is no sheet for first user' do
    negotiation.users[0]._id = nil
    expect(negotiation).to have(1).error_on(:user_sheets)
    expect(negotiation.errors_on(:user_sheets)).to include('Negotiation should have one user_sheet for first user.')
  end

  it 'is invalid if there is no sheet for second user' do
    negotiation.users[1]._id = nil
    expect(negotiation).to have(1).error_on(:user_sheets)
    expect(negotiation.errors_on(:user_sheets)).to include('Negotiation should have one user_sheet for second user.')
  end

  it 'is invalid if there is any proposal not owned by both users' do
    negotiation.proposals << Fabricate.build(:proposal, composer:negotiation.users.first)
    expect(negotiation).to have(1).error_on(:proposals)
    expect(negotiation.errors_on(:proposals)).to include('All proposals should be owned by both users.')
  end

  it 'is invalid if there is any message not owned by any of the users' do
    negotiation.messages << Fabricate.build(:message)
    expect(negotiation).to have(1).error_on(:messages)
    expect(negotiation.errors_on(:messages)).to include('All messages should be owned by one of the users.')
  end

  # Methods
  describe '#proposal' do
    it 'returns the last proposal' do
      expect(negotiation.proposal).to eq negotiation.proposals.last
    end
  end

  describe '#cash_owner(user_id)?' do
    context 'when last proposal has cash' do
      context 'when user owns the cash' do
        it 'returns true' do
          expect(negotiation_composer_cash.cash_owner?(composer_id)).to eq true
        end
      end

      context 'when user does not own the cash' do
        it 'returns false' do
          expect(negotiation_composer_cash.cash_owner?(receiver_id)).to eq false
        end
      end
    end

    context 'when last proposal does not have cash' do
      it 'returns false' do
        expect(negotiation.cash_owner?(composer_id)).to eq false
      end
    end
  end

  describe '#gatekeeper(user_id, action)' do

  end

  describe '#sign_proposal(user_id)' do
    context 'when user can sign' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:sign).and_return(true) }

      it 'triggers proposal sign event' do
        expect(negotiation.proposal).to receive(:sign)
        negotiation.sign_proposal(composer_id)
      end

      it 'returns true' do
        expect(negotiation.sign_proposal(composer_id)).to eq true
      end
    end

    context 'when user cannot sign' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:sign).and_return(false) }

      it 'does not trigger proposal sign event' do
        expect(negotiation.proposal).to_not receive(:sign)
        negotiation.sign_proposal(composer_id)
      end

      it 'returns false' do
        expect(negotiation.sign_proposal(composer_id)).to eq false
      end
    end
  end

  describe '#confirm_proposal(user_id)' do
    context 'when user can confirm' do
      before(:each) do
        negotiation.proposal.state = 'signed'
        negotiation.stub(:gatekeeper).with(composer_id,:confirm).and_return(true)
      end

      it 'triggers proposal confirm event' do
        expect(negotiation.proposal).to receive(:confirm)
        negotiation.confirm_proposal(composer_id)
      end

      it 'returns true' do
        expect(negotiation.confirm_proposal(composer_id)).to eq true
      end
    end

    context 'when user cannot confirm' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:confirm).and_return(false) }

      it 'does not trigger proposal confirm event' do
        expect(negotiation.proposal).to_not receive(:confirm)
        negotiation.confirm_proposal(composer_id)
      end

      it 'returns false' do
        expect(negotiation.confirm_proposal(composer_id)).to eq false
      end
    end
  end

  pending "add methods to let user leave negotiation"

  # Factories
  specify { expect(Fabricate.build(:negotiation)).to be_valid }
end
