require 'spec_helper'

describe Negotiation do
  # Variables
  let(:negotiation)    { Fabricate.build(:negotiation) }
  let(:composer_id)    { negotiation.proposal.composer_id }
  let(:receiver_id)    { negotiation.proposal.receiver_id }
  let(:cash_owner)     { composer_id }
  let(:not_cash_owner) { receiver_id }

  let(:negotiation_with_cash) do
    negotiation.proposal.goods << Fabricate.build(:cash,owner_id:composer_id)
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
  it { should have_field(:hidden).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should validate_presence_of :users }
  it { should_not validate_presence_of :offer }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_presence_of :hidden }

  # Checks
  it 'is invalid if there are more than two users' do
    negotiation.users << Fabricate.build(:user)
    expect(negotiation).to have(1).error_on(:users)
    expect(negotiation.errors_on(:users)).to include('Negotiation should have only two users.')
  end

  it 'is invalid if both users are the same' do
    negotiation.users[1].id = negotiation.users[0].id
    expect(negotiation).to have(1).error_on(:users)
    expect(negotiation.errors_on(:users)).to include('Negotiation users should not be equal.')
  end

  it 'is invalid if there are more than two user sheets' do
    negotiation.user_sheets << Fabricate.build(:user_sheet)
    expect(negotiation).to have(1).error_on(:user_sheets)
    expect(negotiation.errors_on(:user_sheets)).to include('Negotiation should have only two user_sheets.')
  end

  it 'is invalid if there is no sheet for first user' do
    negotiation.users[0].id = nil
    expect(negotiation).to have(1).error_on(:user_sheets)
    expect(negotiation.errors_on(:user_sheets)).to include('Negotiation should have one user_sheet for first user.')
  end

  it 'is invalid if there is no sheet for second user' do
    negotiation.users[1].id = nil
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

  describe '#cash_owner?' do
    context 'when last proposal has cash' do
      context 'when user owns the cash' do
        it 'returns true' do
          expect(negotiation_with_cash.cash_owner?(cash_owner)).to eq true
        end
      end

      context 'when user does not own the cash' do
        it 'returns false' do
          expect(negotiation_with_cash.cash_owner?(not_cash_owner)).to eq false
        end
      end
    end

    context 'when last proposal does not have cash' do
      it 'returns false' do
        expect(negotiation.cash_owner?(composer_id)).to eq false
      end
    end
  end

  describe '#gatekeeper' do
    it 'returns false if user does not belong to negotiation' do
      expect(negotiation.gatekeeper('0',:sign)).to eq false
    end

    it 'returns false if negotiation is hidden' do
      negotiation.hide
      expect(negotiation.gatekeeper(receiver_id,:sign)).to eq false
    end

    describe ':sign action' do
      it 'returns false if proposal is not new' do
        negotiation.proposal.state = 'signed'
        expect(negotiation.gatekeeper(composer_id,:sign)).to eq false
      end

      context 'proposal has cash' do
        it 'returns false for cash owner' do
          expect(negotiation_with_cash.gatekeeper(cash_owner,:sign)).to eq false
        end

        it 'returns true for not cash owner' do
          expect(negotiation_with_cash.gatekeeper(not_cash_owner,:sign)).to eq true
        end
      end

      context 'proposal does not have cash' do
        it 'returns true for composer user' do
          expect(negotiation.gatekeeper(composer_id,:sign)).to eq true
        end

        it 'returns true for receiver user' do
          expect(negotiation.gatekeeper(receiver_id,:sign)).to eq true
        end
      end
    end

    describe ':confirm action' do
      it 'returns false if proposal is not signed' do
        negotiation.proposal.state = 'new'
        expect(negotiation.gatekeeper(composer_id,:confirm)).to eq false
      end

      context 'proposal has cash' do
        it 'returns true for cash owner' do
          expect(negotiation_with_cash.gatekeeper(cash_owner,:confirm)).to eq true
        end

        it 'returns false for not cash owner' do
          expect(negotiation_with_cash.gatekeeper(not_cash_owner,:confirm)).to eq false
        end
      end

      context 'proposal does not have cash' do
        context 'proposal signed by composer' do
          before { negotiation.proposal.signer = composer_id }

          it 'returns false for composer user' do
            expect(negotiation.gatekeeper(composer_id,:confirm)).to eq false
          end

          it 'returns true for receiver user' do
            expect(negotiation.gatekeeper(receiver_id,:confirm)).to eq true
          end
        end

        context 'proposal signed by receiver' do
          before { negotiation.proposal.signer = receiver_id }

          it 'returns true for composer user' do
            expect(negotiation.gatekeeper(composer_id,:confirm)).to eq true
          end

          it 'returns false for receiver user' do
            expect(negotiation.gatekeeper(receiver,:confirm)).to eq false
          end
        end
      end
    end
  end

  describe '#sign_proposal' do
    it 'does not change negotiation hidden field' do
      expect { negotiation.sign_proposal(composer_id) }.to_not change { negotiation.hidden }
    end

    context 'when user can sign' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:sign).and_return(true) }

      it 'calls sign method' do
        expect(negotiation.proposal).to receive(:sign).with(composer_id)
        negotiation.sign_proposal(composer_id)
      end

      it 'returns true' do
        expect(negotiation.sign_proposal(composer_id)).to eq true
      end
    end

    context 'when user cannot sign' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:sign).and_return(false) }

      it 'does not call sign method' do
        expect(negotiation.proposal).to_not receive(:sign).with(composer_id)
        negotiation.sign_proposal(composer_id)
      end

      it 'returns false' do
        expect(negotiation.sign_proposal(composer_id)).to eq false
      end
    end
  end

  describe '#confirm_proposal' do
    context 'when user can confirm' do
      before(:each) do
        negotiation.proposal.state = 'signed'
        negotiation.stub(:gatekeeper).with(composer_id,:confirm).and_return(true)
      end

      it 'calls confirm method' do
        expect(negotiation.proposal).to receive(:confirm).with(composer_id)
        negotiation.confirm_proposal(composer_id)
      end

      it 'changes negotiation hidden field to true' do
        expect { negotiation.confirm_proposal(composer_id) }.to change { negotiation.hidden }.from(false).to(true)
      end

      it 'returns true' do
        expect(negotiation.confirm_proposal(composer_id)).to eq true
      end
    end

    context 'when user cannot confirm' do
      before(:each) { negotiation.stub(:gatekeeper).with(composer_id,:confirm).and_return(false) }

      it 'does not call confirm method' do
        expect(negotiation.proposal).to_not receive(:confirm).with(composer_id)
        negotiation.confirm_proposal(composer_id)
      end

      it 'does not change negotiation hidden field' do
        expect { negotiation.confirm_proposal(composer_id) }.to_not change { negotiation.hidden }
      end

      it 'returns false' do
        expect(negotiation.confirm_proposal(composer_id)).to eq false
      end
    end
  end

  describe '#hide' do
    it 'sets hidden field to true' do
      negotiation.hide
      expect(negotiation.hidden).to eq true
    end
  end

  # Factories
  specify { expect(Fabricate.build(:negotiation)).to be_valid }
end
