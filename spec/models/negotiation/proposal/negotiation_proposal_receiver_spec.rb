require 'spec_helper'

describe Negotiation::Proposal::Receiver do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:receiver) { proposal.receiver }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
    it { should embed_many(:products).of_type(Negotiation::Proposal::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:nick).of_type(String) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields(:nick, :image_fingerprint).from('user.profile') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nick }
  end

  describe 'Factories' do
    specify { expect(receiver).to be_valid }

    it 'creates one negotiation' do
      expect { receiver.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#user' do
    subject { receiver.user }

    it { should be_instance_of(User) }

    it 'returns user who received current proposal' do
      expect(subject.id).to eq receiver.proposal.user_receiver_id
    end
  end
end
