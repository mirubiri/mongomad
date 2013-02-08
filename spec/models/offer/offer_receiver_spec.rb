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
    it { should have_field(:name).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :offer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(receiver.valid?).to be_true, "Is not valid because #{receiver.errors}" }

    it 'Creates one offer' do
      expect { receiver.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'on save' do
    it 'Uploads an image' do
      receiver.save
      File.exist?(File.new(receiver.image.path)).should be_true
    end
  end

  describe '#auto_update' do
    it 'calls update_user_data' do
       # Use relationship.target to access to the wrapped object
      receiver.target.should_receive(:update_user_data)
      receiver.auto_update
    end

    it 'calls update_products' do
      receiver.target.should_receive(:update_products)
      receiver.auto_update
    end

    it 'updates receiver name with the current user receiver name' do
      receiver.offer.user_receiver.profile.stub(:name).and_return('updated')
      receiver.auto_update
      receiver.name.should eq 'updated'
    end

    it 'updates receiver image_name with the current user receiver image_name' do
      receiver.offer.user_receiver.profile.stub(:image_name).and_return('updated.png')
      receiver.auto_update
      receiver.image_name.should eq 'updated.png'
    end
  end
end
