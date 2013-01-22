require 'spec_helper'

describe Offer::Receiver do
  let(:receiver) do
    Fabricate.build(:offer).receiver
  end

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should_not have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(receiver.valid?).to be_true }
    it 'Creates one offer' do
      expect { receiver.save }.to change{ Offer.count}.by(1)
    end
    it 'Creates two users' do
      expect { receiver.save }.to change{ User.count }.by(2)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      receiver.save
      File.exist?(File.new(receiver.image.path)).should be_true
    end
  end
end
