require 'spec_helper'

describe Offer do
  let(:offer) { Fabricate.build(:offer) }
  after(:each) { offer && offer.polymorphic_offer.destroy }

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_offer }
    it { should embed_one :composer }
    it { should embed_one :receiver }
    it { should embed_one :money }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_offer }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
  end

  describe 'Factories' do
    specify { offer.should be_valid }
    specify { offer.save.should be_true }
  end
end