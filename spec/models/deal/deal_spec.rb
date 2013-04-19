require 'spec_helper'

describe Deal do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }

  describe 'Relations' do
    it { should have_and_belong_to_many(:signers).of_type(User) }
    it { should embed_one(:conversation).of_type(Deal::Conversation) }
    it { should embed_one(:agreement).of_type(Deal::Agreement) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should accept_nested_attributes_for :conversation }
    it { should accept_nested_attributes_for :agreement }
  end

  describe 'Validations' do
    xit { should_not validate_presence_of :signers }
    it { should validate_presence_of :conversation }
    it { should validate_presence_of :agreement }
  end

  describe 'Factories' do
    specify { expect(deal).to be_valid }
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
end
