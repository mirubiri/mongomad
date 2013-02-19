require 'spec_helper'

describe Deal do
  let(:deal) do
    Fabricate.build(:deal, negotiation:Fabricate(:negotiation))
  end

  describe 'Relations' do
    it { should embed_one(:agreement).of_type(Deal::Agreement) }
    it { should embed_one(:conversation).of_type(Deal::Conversation) }
    it { should have_and_belong_to_many(:signers).of_type(User) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :signers }
  end

  describe 'Factories' do
    specify { expect(deal.valid?).to eq true }
    specify { expect(deal.save).to eq true }

    it 'creates one negotiation' do
      expect { deal.save }.to change{ Negotiation.count }.by(1)
    end

    it 'creates one offer' do
      expect { deal.save }.to change{ Offer.count }.by(1)
    end

    it 'creates two different users' do
      expect { deal.save }.to change{ User.count }.by(2)
    end
  end

  describe '.generate(negotiation)' do
    xit 'creates a deal with the given params'
  end

  describe '#publish' do
    xit 'saves the deal'
  end

  describe '#unpublish' do
    xit 'removes the deal'
  end

  describe '#self_update' do
    xit 'updates itself'
  end

  describe '#post_message(message_params)' do
    xit 'adds to deal a new message from the given hash'
  end
end
