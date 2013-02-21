require 'spec_helper'

describe Offer::Receiver do
  let(:offer) { Fabricate.build(:offer) }
  let(:receiver) { offer.receiver }
  let(:receiver_things_params) { params_for_offer(offer)[:receiver_things] }

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

  describe '#alter_products(params)' do
    after { receiver.alter_products(receiver_things_params) }

    it 'removes the current list of products' do
      receiver.products.should_receive(:destroy)
    end
    
    it 'add the given list of products' do
      receiver.target.should_receive(:add_products).with(receiver_things_params)
    end

    it 'calls to self_update' do
      pending 'pensar si llamarlo o no'
    end
  end

  describe '#add_products(params)' do
    it 'creates a product for each passed product_params' do
      product_list=receiver.products.dup
      receiver.products.destroy
      receiver.add_products(product_list)
      receiver.self_update
      expect(receiver.products).to be_like product_list
    end
  end

  describe 'On save' do
    it 'has an image' do
      receiver.save
      File.exist?(File.new(receiver.image.path)).should eq true
    end
  end

  describe '#self_update' do
    it 'calls update_user_data' do
      # Use relationship.target to access to the wrapped object
      receiver.target.should_receive(:update_user_data)
      receiver.self_update
    end

    it 'calls update_products' do
      receiver.target.should_receive(:update_products)
      receiver.self_update
    end

    it 'updates receiver name with the current user receiver name' do
      receiver.offer.user_receiver.profile.stub(:name).and_return('updated')
      receiver.self_update
      receiver.name.should eq 'updated'
    end

    it 'updates receiver image_name with the current user receiver image_name' do
      receiver.offer.user_receiver.profile.stub(:image_name).and_return('updated.png')
      receiver.self_update
      receiver.image_name.should eq 'updated.png'
    end
  end
end
