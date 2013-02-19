require 'spec_helper'

describe Deal do
  let(:deal) do
    Fabricate.build(:deal, negotiation:Fabricate(:negotiation))
  end

  describe 'Relations' do
    it { should embed_one(:agreement).of_type(Deal::Agreement) }
    it { should embed_many(:messages).of_type(Deal::Message) }
    it { should_not have_and_belong_to_many(:users) }
    it { should have_and_belong_to_many(:signers).of_type(User) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :messages }
    it { should_not validate_presence_of :users }
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

  describe '.make_with(negotiation)' do
    xit 'makes a new deal from the given negotiation'
  end

  describe '#post_message(params=[])' do
    xit 'adds to deal a new message from the given hash'
  end
end
