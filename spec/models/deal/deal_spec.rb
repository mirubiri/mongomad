require 'spec_helper'

describe Deal do
  let(:deal) do
    Fabricate.build(:deal)
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
  end

  describe 'Factories' do
    specify { expect(deal.valid?).to be_true }
    specify { expect(deal.save).to be_true }
  end
end
