require 'spec_helper'

describe Negotiation do

  let(:negotiation) { Fabricate.build(:negotiation) }
  let(:first_user)  { negotiation._users.first }
  let(:second_user) { negotiation._users.last }


  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
  it { should embed_many :user_sheets }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:performer).of_type(Moped::BSON:ObjectId)}
  it { should have_field :state }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_presence_of :performer }
  it { should validate_presence_of :state }
  xit 'should validate_presence_of two user_sheets corresponding to _users'

  # Methods
  describe '#proposal' do
    it 'returns the current proposal'
  end

  describe '#make_proposal(user,products)' do

    it 'make a proposal with the given products'
    it 'adds the new proposal to proposals list'
  end

  describe '#send_message(user,message)' do
    it 'writes a new message for given user and text'
    it 'returns true if written'
    it 'returns false if given user is not participating'

    pending 'Como hay que repetirlo para deal, pensar en hacer un shared_example'
  end

  ['sign', 'confirm','cancel','new'].each do |action|
    describe "##{action}" do
      it 'returns false if given user is not present in negotiation' do
        expect(negotiation.send(action,Fabricate.build(:user))).to eq false
      end

      it 'returns false if negotiation ended' do
        negotiation.end(first_user)
        expect(negotiation.send(action,user)).to eq false
      end

      it 'does not set performer to user' do
        expect { negotiation.send(action,Fabricate.build(:user)) }.not_to change { negotiation.performer }
      end
    end
  end


  describe '#sign(user)' do
    before(:each) { negotiation.state = 'new' }
    context 'negotiation is new' do
      it 'sets the negotiation state to signed'
      it 'sets last action performer to user'
      it 'saves the negotiation'
      it 'returns true'
    end

    context 'negotiation is not new' do
      it 'returns false'
    end
  end

  describe '#confirm(user)' do
    before(:each) { negotiation.state='signed'}
    context 'negotiation is signed by other user' do
      it 'sets negotiation state to confirmed'
      it 'sets last action performed to user'
      it 'generates a deal'
      it 'removes the negotiation if deal is generated'
      it 'returns true'
    end

    context 'negotiation is not signed by second user' do
      it 'returns false'
    end
  end

  describe '#new(user)' do
    it 'returns false if user is not present in the negotiation'
    it 'sets negotiation state to new'
    it 'sets last action performer to user'
    it 'saves the negotiation'
  end

  describe '#cancel(user)' do
    it 'returns false if user is not present in the negotiation'
    it 'sets negotiation in canceled state'
    it 'sets last action performer to user'
    it 'saves the negotiation'
  end

  describe '#actions_for(user)' do
    it 'returns an array with the allowed actions for user'
    it 'returns an empty array if not allowed actions for user'
  end

  describe 'present?(user)' do
    it 'returns true if user is present in the negotiation'
    it 'returns false if user is not present in the negotiation'
  end

  describe 'performed?(user)' do
    it 'returns true if user was who executed the last action'
    it 'returns false if user did not executed the las action'
  end

  describe 'money_owner' do
    it 'returns the id of user whose has money'
    it 'returns nil if nobody has money'
  end

  describe 'money?' do
    it 'returns true when money exists'
    it 'returns false when money not exists'
  end

  describe 'end(user)' do
    context 'user present' do
      it 'removes the user form the negotiation'
      it 'sets negotiation to ended state'
      it 'sets last action performer to user'
      it 'returns true'
    end

    context 'user not present' do
      it 'returns false'
      it 'does not change the negotiation status'
    end

    context 'user is alone' do
      it 'destroys the negotiation'
    end
  end

  # Factories
  specify { expect(negotiation).to be_valid }


  #   it 'creates one offer' do
  #     expect { negotiation.save }.to change{ Offer.count }.by(1)
  #   end

  #   it 'creates two different users' do
  #     expect { negotiation.save }.to change{ User.count }.by(2)
  #   end
  # end

  # describe '#seal_deal' do
  #   context 'When negotiation is saved' do
  #     before { negotiation.save }

  #     context 'When last proposal is signed' do
  #       before { proposal.state = :composer_signed }

  #       let(:deal) { negotiation.seal_deal }

  #       it 'returns a saved deal' do
  #         expect(deal).to be_persisted
  #       end

  #       it 'add the deal to composer in negotiation' do
  #         expect(deal).to eq proposal.user_composer.deals.first
  #       end

  #       it 'add the deal to receiver in negotiation' do
  #         expect(deal).to eq proposal.user_composer.deals.first
  #       end

  #       it 'returns a deal whose conversation has no messages' do
  #         expect(deal.conversation.messages).to have(0).messages
  #       end

  #       it 'returns a deal whose agreement has the values from original negotiation' do
  #         expect(deal.agreement).to be_like negotiation
  #       end
  #     end

  #     context 'When last proposal is not signed' do
  #       before { proposal.state = :composer_canceled }

  #       it 'returns nil' do
  #         expect(negotiation.seal_deal).to eq nil
  #       end
  #     end
  #   end

  #   context 'When negotiation is not saved' do
  #     it 'returns nil' do
  #       expect(negotiation.seal_deal).to eq nil
  #     end
  #   end
  # end
end

