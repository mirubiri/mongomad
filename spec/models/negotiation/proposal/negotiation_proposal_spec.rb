require 'spec_helper'

describe Negotiation::Proposal do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:negotiation_composer) { negotiation.negotiators.find(proposal.user_composer_id) }
  let(:negotiation_receiver) { negotiation.negotiators.find(proposal.user_receiver_id) }
  let(:proposals) do
    proposal_composer_money = Fabricate(:offer_composer_money).start_negotiation.proposals.last
    proposal_receiver_money = Fabricate(:offer_receiver_money).start_negotiation.proposals.last
    [ proposal_composer_money, proposal_receiver_money ]
  end

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

  # ########################################################################################################
  # describe '#can_sign?(negotiator)' do
  #   context 'When proposal is in :not_signed state' do
  #     context 'When composer offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'no'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'si'
  #       end
  #     end
  #     context 'When receiver offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'si'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'no'
  #       end
  #     end
  #     context 'When there is no money in proposal' do
  #       it 'si'
  #     end
  #   end
  #   context 'When proposal is not in :not_signed state' do
  #     it 'no'
  #   end
  # end

  # ########################################################################################################
  # describe '#sign(negotiator)' do
  #   context 'When proposal is in :not_signed state' do
  #     context 'When composer offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'no'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'si'
  #       end
  #     end
  #     context 'When receiver offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'si'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'no'
  #       end
  #     end
  #     context 'When there is no money in proposal' do
  #       it 'si'
  #     end
  #   end
  #   context 'When proposal is not in :not_signed state' do
  #     it 'no'
  #   end
  # end

  # ########################################################################################################
  # describe '#can_unsign?(negotiator)' do
  #   context 'When proposal is in :signed_by_composer state' do
  #     context 'When composer offers money' do
  #       it 'no'
  #     end
  #     context 'When composer does not offer money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'si'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'no'
  #       end
  #     end
  #   end
  #   context 'When proposal is in :signed_by_receiver state' do
  #     context 'When receiver offers money' do
  #       it 'no'
  #     end
  #     context 'When receiver does not offer money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'no'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'si'
  #       end
  #     end
  #   end
  #   context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
  #     it 'no'
  #   end
  # end

  # ########################################################################################################
  # describe '#unsign(negotiator)' do
  #   context 'When proposal is in :signed_by_composer state' do
  #     context 'When composer offers money' do
  #       it 'no'
  #     end
  #     context 'When composer does not offer money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'si'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'no'
  #       end
  #     end
  #   end
  #   context 'When proposal is in :signed_by_receiver state' do
  #     context 'When receiver offers money' do
  #       it 'no'
  #     end
  #     context 'When receiver does not offer money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'no'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'si'
  #       end
  #     end
  #   end
  #   context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
  #     it 'no'
  #   end
  # end

  # ########################################################################################################
  # describe '#can_confirm?(negotiator)' do
  #   context 'When proposal is in :signed_by_composer state' do
  #     context 'When given negotiator is the composer of current proposal' do
  #       it 'no'
  #     end
  #     context 'When given negotiator is the receiver of current proposal' do
  #       it 'si'
  #     end
  #   end
  #   context 'When proposal is in :signed_by_receiver state' do
  #     context 'When given negotiator is the composer of current proposal' do
  #       it 'si'
  #     end
  #     context 'When given negotiator is the receiver of current proposal' do
  #       it 'no'
  #     end
  #   end
  #   context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
  #     it 'no'
  #   end
  # end

  # ########################################################################################################
  # describe '#confirm(negotiator)' do
  #   context 'When proposal is in :signed_by_composer state' do
  #     context 'When given negotiator is the composer of current proposal' do
  #       it 'no'
  #     end
  #     context 'When given negotiator is the receiver of current proposal' do
  #       it 'si'
  #     end
  #   end
  #   context 'When proposal is in :signed_by_receiver state' do
  #     context 'When given negotiator is the composer of current proposal' do
  #       it 'si'
  #     end
  #     context 'When given negotiator is the receiver of current proposal' do
  #       it 'no'
  #     end
  #   end
  #   context 'When proposal is not in :signed_by_composer nor :signed_by_receiver state' do
  #     it 'no'
  #   end
  # end

  # ########################################################################################################
  # describe '#allowed_actions2' do
  #   context 'When proposal is in :not_signed state' do
  #     context 'When composer offers money' do
  #       # context 'When given negotiator is the composer of current proposal' do
  #       #   it '/'
  #       # end
  #       # context 'When given negotiator is the receiver of current proposal' do
  #       #   it 'SIGN'
  #       # end

  #     it 'composer [:/]  ,receiver [:sING]'
  #     end
  #     context 'When receiver offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'SIGN'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it '/'
  #       end
  #     end
  #     context 'When there is no money in proposal' do
  #       it 'SIGN'
  #     end
  #   end
  #   context 'When proposal is in :signed_by_composer state' do
  #     context 'When composer offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it '/'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'CONFIRM'
  #       end
  #     end
  #     context 'When composer does not offer money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'UNSIGN'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'CONFIRM'
  #       end
  #     end
  #   end
  #   context 'When proposal is in :signed_by_receiver state' do
  #     context 'When receiver offers money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'CONFIRM'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it '/'
  #       end
  #     end
  #     context 'When receiver does not offer money' do
  #       context 'When given negotiator is the composer of current proposal' do
  #         it 'CONFIRM'
  #       end
  #       context 'When given negotiator is the receiver of current proposal' do
  #         it 'UNSIGN'
  #       end
  #     end
  #   end
  #   context 'When proposal is in :confirmed state' do
  #     it '/'
  #   end
  # end

  #########################################################################################################
  describe 'allowed_actions' do
    it 'let both negotiators make a new proposal' do
      expect(proposal.allowed_actions[:composer]).to include :new
      expect(proposal.allowed_actions[:receiver]).to include :new
    end

    context 'When some one offers money' do
      [ Fabricate(:offer_composer_money).start_negotiation.proposals.last,
        Fabricate(:offer_receiver_money).start_negotiation.proposals.last ].each do |proposal|

        user_with_money = proposal.user_composer_id == proposal.money.user_id ? :composer : :receiver
        user_without_money = user_with_money == :composer ? :receiver : :composer

        context 'The negotiator who offers money' do
          it 'cannot sign' do
            expect(proposal.allowed_actions[user_with_money]).not_to include :sign
          end

          it 'cannot unsign' do
            expect(proposal.allowed_actions[user_with_money]).not_to include :unsign
          end

          context 'When proposal is signed by the :user_with_money' do
            before { proposal.state = :"signed_by_#{user_with_money.to_s}" }

            it 'can confirm' do
              expect(proposal.allowed_actions[user_with_money]).not_to include :confirm
            end
          end

          context 'When proposal is signed by the :user_without_money' do
            before { proposal.state = :"signed_by_#{user_without_money.to_s}" }

            it 'cannot confirm' do
              expect(proposal.allowed_actions[user_with_money]).to include :confirm
            end
          end

          context 'The other negotiator' do
            context 'When proposal is not signed' do
              before { proposal.state = :not_signed }

              it 'can sign' do
                expect(proposal.allowed_actions[user_without_money]).to include :sign
              end

              it 'cannot unsign' do
                expect(proposal.allowed_actions[user_without_money]).not_to include :unsign
              end
            end

            context 'When proposal is signed by the :user_with_money' do
              before { proposal.state = :"signed_by_#{user_with_money.to_s}" }

              it 'cannot sign' do
                expect(proposal.allowed_actions[user_without_money]).not_to include :sign
              end

              it 'cannot unsign' do
                expect(proposal.allowed_actions[user_without_money]).not_to include :unsign
              end
            end

            context 'When proposal is signed by the :user_without_money' do
              before { proposal.state = :"signed_by_#{user_without_money.to_s}" }

              it 'cannot sign' do
                expect(proposal.allowed_actions[user_without_money]).not_to include :sign
              end

              it 'can unsign' do
                expect(proposal.allowed_actions[user_without_money]).to include :unsign
              end
            end

            it 'cannot confirm' do
              expect(proposal.allowed_actions[user_without_money]).not_to include :confirm
            end
          end
        end
      end
    end

    context 'When no one offers money' do
      before { proposal.state = :signed_by_composer } # TODO: REVISAR ESTO, deberia ser por defecto asi!!!!

      context 'The composer' do
        it 'cannot sign' do
          expect(proposal.allowed_actions[:composer]).not_to include :sign
        end

        it 'can unsign' do
          expect(proposal.allowed_actions[:composer]).to include :unsign
        end

        it 'cannot confirm' do
          expect(proposal.allowed_actions[:composer]).not_to include :confirm
        end

        context 'The receiver' do
          it 'cannot sign' do
            expect(proposal.allowed_actions[:receiver]).not_to include :sign
          end

          it 'cannot unsign' do
            expect(proposal.allowed_actions[:receiver]).not_to include :unsign
          end

          it 'can confirm' do
            expect(proposal.allowed_actions[:receiver]).to include :confirm
          end
        end
      end
    end
  end
end
