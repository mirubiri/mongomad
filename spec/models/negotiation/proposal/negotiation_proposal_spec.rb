require 'spec_helper'

describe Negotiation::Proposal do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:negotiation_composer) { proposal.negotiation.negotiators.find(proposal.user_composer_id) }
  let(:negotiation_receiver) { proposal.negotiation.negotiators.find(proposal.user_receiver_id) }
  #let(:composer) { proposal.user_composer }
  #let(:receiver) { proposal.user_receiver }

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
    it { should have_field(:state).of_type(Symbol).with_default_value_of(:new) }
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
    it { should validate_inclusion_of(:state).to_allow([:new, :signed_by_composer, :signed_by_receiver, :confirmed]) }
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

  describe '#user_composer' do
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

  describe '#can_sign?(negotiator)' do
    it 'calls permitted_actions method' do
      expect(proposal).should_receive(:permitted_actions).with(:negotiation_composer)
      proposal.can_sign?(negotiation_composer)
    end

    context 'When proposal is in :new state' do
      before { proposal.state = :new }

      context 'When receiver offers money' do
        before { proposal.money.user_id = proposal.user_receiver_id }

        context 'When given negotiator is the composer of the current proposal' do
          it 'returns false' do
            proposal.stub(:permitted_actions).with(:negotiation_composer).and_return([:confirm])
            expect(proposal.can_sign?(negotiation_composer)).to eq false
          end
        end

        context 'When given negotiator is the receiver of the current proposal' do
          it 'returns true' do
            proposal.stub(:permitted_actions).with(:negotiation_receiver).and_return([:sign])
            expect(proposal.can_sign?(negotiation_receiver)).to eq true
          end
        end
      end

      context 'when receiver does not offer money' do
        before { proposal.money.user_id = proposal.user_composer_id }

        context 'When given negotiator is the composer of the current proposal' do
          it 'returns true' do
            proposal.stub(:permitted_actions).with(:negotiation_composer).and_return([:sign])
            expect(proposal.can_sign?(negotiation_composer)).to eq true
          end
        end

        context 'When given negotiator is the receiver of the current proposal' do
           it 'returns false' do
            proposal.stub(:permitted_actions).with(:negotiation_receiver).and_return([:confirm])
            expect(proposal.can_sign?(negotiation_composer)).to eq false
          end
        end
      end
    end

    context 'When proposal is not in :new state' do
      before { proposal.state = :signed_by_composer }

      it 'returns false' do
        proposal.stub(:permitted_actions).with(:negotiation_receiver).and_return([:confirm])
        expect(proposal.can_sign?(negotiation_composer)).to eq false
      end
    end
  end

  describe '#sign(negotiator)' do
    context 'When proposal is in :new state' do
      before { proposal.state = :new }

      context 'When receiver offers money' do
        before { proposal.money.user_id = proposal.user_receiver_id }

        context 'When given negotiator is the composer of the current proposal' do
          it 'returns false' do
            expect(proposal.sign(negotiation_composer)).to eq false
          end
        end

        context 'When given negotiator is the receiver of the current proposal' do
          it 'signs the proposal' do
            proposal.sign(negotiation_receiver)
            expect(proposal.state).to eq :signed_by_receiver
          end

          it 'returns true' do
            expect(proposal.sign(negotiation_receiver)).to eq true
          end
        end
      end

      context 'when receiver does not offer money' do
        before { proposal.money.user_id = proposal.user_composer_id }

        context 'When given negotiator is the composer of the current proposal' do
          it 'signs the proposal' do
            proposal.sign(negotiation_composer)
            expect(proposal.state).to eq :signed_by_receiver
          end

          it 'returns true' do
            expect(proposal.sign(negotiation_composer)).to eq true
          end
        end

        context 'When given negotiator is the receiver of the current proposal' do
          it 'returns false' do
            expect(proposal.sign(negotiation_receiver)).to eq false
          end
        end
      end
    end

    context 'When proposal is not in :new state' do
      before { proposal.state = :signed_by_composer }
      it 'returns false' do
        expect(proposal.sign(negotiation_composer)).to eq false
      end
    end
  end

  describe '#can_unsign?(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When receiver offers money' do
        it 'no'
      end
      context 'when receiver does not offer money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'si'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'si'
        end
      end
      context 'when receiver does not offer money' do
        it 'no'
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  describe '#unsign(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When receiver offers money' do
        it 'no'
      end
      context 'when receiver does not offer money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'si'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'no'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'si'
        end
      end
      context 'when receiver does not offer money' do
        it 'no'
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  describe '#can_confirm?(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When receiver offers money' do
        it 'no'
      end
      context 'when receiver does not offer money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'no'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'no'
        end
      end
      context 'when receiver does not offer money' do
        it 'no'
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end

  describe '#confirm(negotiator)' do
    context 'When proposal is in :signed_by_composer state' do
      context 'When receiver offers money' do
        it 'no'
      end
      context 'when receiver does not offer money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'no'
        end
      end
    end
    context 'When proposal is in :signed_by_receiver state' do
      context 'When receiver offers money' do
        context 'When given negotiator is the composer of the current proposal' do
          it 'si'
        end
        context 'When given negotiator is the receiver of the current proposal' do
          it 'no'
        end
      end
      context 'when receiver does not offer money' do
        it 'no'
      end
    end
    context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
      it 'no'
    end
  end
end
