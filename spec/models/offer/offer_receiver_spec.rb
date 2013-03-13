require 'spec_helper'

describe Offer::Receiver do
  # let(:offer) { Fabricate.build(:offer) }
  # let(:receiver) { offer.receiver }
  # let(:receiver_things_params) { params_for_offer(offer)[:receiver_things] }

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(receiver.valid?).to eq true }

    it 'creates one offer' do
      expect { receiver.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      receiver.save
      File.exist?(File.new(receiver.image.path)).should eq true
    end
  end
end
