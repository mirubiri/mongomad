require 'spec_helper'

describe Negotiation::Proposal do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:negotiation_composer) { proposal.negotiation.negotiators.find(proposal.user_composer_id) }
  let(:negotiation_receiver) { proposal.negotiation.negotiators.find(proposal.user_receiver_id) }
  let(:negotiator) { negotiation.negotiators.last }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_one(:composer).of_type(Negotiation::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Negotiation::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Negotiation::Proposal::Money) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_composer_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_receiver_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:state).of_type(Symbol).with_default_value_of(:not_signed) }
    it { should accept_nested_attributes_for :composer }
    it { should accept_nested_attributes_for :receiver }
    it { should accept_nested_attributes_for :money }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :negotiation }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :money }
    it { should validate_presence_of :user_composer_id }
    it { should validate_presence_of :user_receiver_id }
    it { should validate_presence_of :state }
    it { should validate_inclusion_of(:state).to_allow([:not_signed, :signed_by_composer, :signed_by_receiver, :confirmed]) }
  end

  describe 'Factories' do
    specify { expect(proposal).to be_valid }

    it 'creates one negotiation' do
      expect { proposal.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#user_composer' do
    context 'When proposal has no negotiation assigned' do
      it 'returns nil' do
        proposal.negotiation = nil
        expect(proposal.user_composer).to eq nil
      end
    end

    context 'When proposal has a negotiation assigned' do
      it 'returns the user of the negotiation who made the proposal' do
        expect(proposal.user_composer).to eq negotiation_composer
      end
    end
  end

  describe '#user_receiver' do
    context 'When proposal has no negotiation assigned' do
      it 'returns nil' do
        proposal.negotiation = nil
        expect(proposal.user_receiver).to eq nil
      end
    end

    context 'When proposal has a negotiation assigned' do
      it 'returns the user of the negotiation who received the proposal' do
        expect(proposal.user_receiver).to eq negotiation_receiver
      end
    end
  end
=begin
  ########################################################################################################
  describe '#can_sign?(negotiator)' do
    context 'When proposal is in :not_signed state' do
      context 'When composer offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'si'
        end
      end
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'no'
        end
      end
      context 'When there is no money in proposal' do
        it 'si'
      end
    end
    context 'When proposal is not in :not_signed state' do
      it 'no'
    end
  end

  ########################################################################################################
  describe '#sign(negotiator)' do
    context 'When proposal is in :not_signed state' do
      context 'When composer offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'si'
        end
      end
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'no'
        end
      end
      context 'When there is no money in proposal' do
        it 'si'
      end
    end
    context 'When proposal is not in :not_signed state' do
      it 'no'
    end
  end

  ########################################################################################################
  describe '#can_unsign?(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When composer offers money' do
        it 'no'
      end
      context 'When composer does not offer money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'no'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        it 'no'
      end
      context 'When receiver does not offer money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'si'
        end
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  ########################################################################################################
  describe '#unsign(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When composer offers money' do
        it 'no'
      end
      context 'When composer does not offer money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'no'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        it 'no'
      end
      context 'When receiver does not offer money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'si'
        end
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  ########################################################################################################
  describe '#can_confirm?(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When given negotiator is the composer of current proposal' do
        it 'no'
      end
      context 'When given negotiator is the receiver of current proposal' do
        it 'si'
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When given negotiator is the composer of current proposal' do
        it 'si'
      end
      context 'When given negotiator is the receiver of current proposal' do
        it 'no'
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  ########################################################################################################
  describe '#confirm(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When given negotiator is the composer of current proposal' do
        it 'no'
      end
      context 'When given negotiator is the receiver of current proposal' do
        it 'si'
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When given negotiator is the composer of current proposal' do
        it 'si'
      end
      context 'When given negotiator is the receiver of current proposal' do
        it 'no'
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  ########################################################################################################
  describe '#allowed_actions2' do
    context 'When proposal is in :not_signed state' do
      context 'When composer offers money' do
        # context 'When given negotiator is the composer of current proposal' do
        #   it '/'
        # end
        # context 'When given negotiator is the receiver of current proposal' do
        #   it 'SIGN'
        # end

      it 'composer [:/]  ,receiver [:sING]'
      end
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'SIGN'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it '/'
        end
      end
      context 'When there is no money in proposal' do
        it 'SIGN'
      end
    end
    context 'When proposal is in :signed_by_composer state' do
      context 'When composer offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it '/'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'CONFIRM'
        end
      end
      context 'When composer does not offer money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'UNSIGN'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'CONFIRM'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'CONFIRM'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it '/'
        end
      end
      context 'When receiver does not offer money' do
        context 'When given negotiator is the composer of current proposal' do
          it 'CONFIRM'
        end
        context 'When given negotiator is the receiver of current proposal' do
          it 'UNSIGN'
        end
      end
    end
    context 'When proposal is in :confirmed state' do
      it '/'
    end
  end

  ########################################################################################################
=end
  describe '#allowed_actions' do
    let(:composer_allowed_actions) { negotiation.allowed_actions[:composer_actions] }
    let(:receiver_allowed_actions) { negotiation.allowed_actions[:receiver_actions] }

    it 'both can make a new proposal' do
      expect(composer_allowed_actions).to include (:new)
    end

    [_,_].each do |negotiation|
      user_with_money=negotiation.money.user_id
      users=[negotiation.proposal.user_composer_id=>:composer,negotiation.proposal.user_receiver_id=>:receiver]
      users[user_with_money]
          context 'Who offers money' do
      it 'can never sign'
      it 'can never unsign'
      it 'can confirm if signed'

      context 'the other' do
        it 'can sign if not signed'
        it 'can unsign if signed'
        it 'can never confirm'
      end
    end

    context 'When nobody offers money' do
      context 'Who signs' do
        it 'can never sign'
        it 'can unsign'
        it 'can never confirm'

        context 'the other' do
          it 'can never sign'
          it 'can never unsign'
          it 'can confirm'
        end
      end
    end
  end
end
