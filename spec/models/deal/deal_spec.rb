require 'spec_helper'

describe Deal do
  let(:deal) do
    Fabricate.build(:deal, negotiation:Fabricate(:negotiation))
  end

  describe 'Relations' do
    it { should embed_one(:agreement).of_type(Deal::Agreement) }
    it { should embed_many(:messages).of_type(Deal::Message) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :messages }
    it { should validate_presence_of :users }
  end

  describe 'Factories' do
    specify { expect(deal.valid?).to be_true, "Is not valid because #{deal.errors}" }
    specify { expect(deal.save).to be_true }

    it 'Creates one negotiation' do
      expect { deal.save }.to change{ Negotiation.count }.by(1)
    end

    it 'Creates one offer' do
      expect { deal.save }.to change{ Offer.count }.by(1)
    end

    it 'Creates two different users' do
      expect { deal.save }.to change{ User.count }.by(2)
    end
  end

  describe '.generate_from(accepted_negotiation)' do
    xit 'Generates a new deal from an accepted_negotiation'
  end
end
