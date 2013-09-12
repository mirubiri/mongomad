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
  xit { should have_field(:performer).of_type(Moped::BSON:ObjectId)}
  it { should have_field :state }

  # Validations
  it { should_not validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }
  it { should validate_presence_of :performer }
  it { should validate_presence_of :state }
  it 'should validate_presence_of two user_sheets corresponding to _users'

  # Methods

=begin
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

      it 'does change performer if user is not present in negotiation' do
        expect { negotiation.send(action,Fabricate.build(:user)) }.not_to change { negotiation.performer }
      end
    end
  end


  describe ':states' do
    context 'when money present' do
      it 'has initial state set to :new if composer holds the money'
      it 'has initial state set to :composer_signed if receiver holds the money'
    end

    context 'when money not present' do
      it 'has initial_state set to :composer_signed'
    end

    it 'changes state from :composer_signed to :receiver_confirmed on :receiver_confirm'
    it 'changes state from :new to :receiver_signed on :receiver_sign'
    it 'changes state from :receiver_signed to :composer_confirmed on :composer_confirm'
    it 'changes state from :all to :canceled on :cancel'
    it 'changes state from :all to :ended on :end'
  end

  describe '#new(user)' do
    it 'returns false if user is not present in the negotiation'
    it 'sets negotiation state to new'
    it 'sets last action performer to user'
    it 'saves the negotiation'
  end

  describe '#sign(user)' do
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

  describe '#cancel(user)' do
    it 'returns false if user is not present in the negotiation'
    it 'sets negotiation in canceled state'
    it 'sets last action performer to user'
    it 'saves the negotiation'
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

  describe '#initial_state' do
    context 'Money present' do
    end

    context 'No money present' do
    end
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

  # Factories
  specify { expect(negotiation).to be_valid }
=end
end

