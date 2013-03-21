require 'spec_helper'

describe Offer::Receiver do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:receiver) { offer.receiver }
  let(:products_params) { params_for_offer(offer)[:composer_things] }
  let(:thing) { user_receiver.things.last }

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

=begin
  describe '#add_products(products_params)' do
    it 'add a list of products from given parameters' do
      new_receiver = offer.receiver.clone
      new_receiver.products.destroy
      new_receiver.add_products(products_params)
      new_receiver.products.should be_like receiver.products
    end

    it 'calls to self_update method' do
      receiver.should_receive(:self_update!)
      receiver.add_products(products_params)
    end

    it 'returns a valid receiver' do
      receiver.add_products(products_params)
      receiver.should be_valid
    end

    it 'does not persist the receiver' do
      receiver.should_not be_persisted
    end

    it 'raises exception if self_update! fails' do
      receiver.stub(:self_update!).and_raise("StandardError")
      expect { receiver.self_update! }.to raise_error
    end
  end

  describe '#alter_contents(products_params)' do
    it 'removes the current list of products' do
      receiver.products.should_receive(:destroy)
      receiver.alter_contents(products_params)
    end

    it 'add a new list of products from the given parameters' do
      receiver.should_receive(:add_products).with(products_params)
    end
  end

  describe '#self_update!' do
    it 'updates name with the current user_receiver name' do
      receiver.name.stub(:name).and_return('updated')
      receiver.self_update!
      receiver.name.should eq 'updated'
    end

    it 'updates image_name with the current user_receiver image_name' do
      receiver.image_name.stub(:image_name).and_return('updated.png')
      receiver.self_update!
      receiver.receiver.image_name.should eq 'updated.png'
    end

    it 'calls update_user_data method' do
      receiver.should_receive(:update_user_data)
      receiver.self_update!
    end

    it 'calls update_products method' do
      receiver.should_receive(:update_products)
      receiver.self_update!
    end

    it 'calls to product.self_update! method for each product' do
      receiver.product.each do |product|
        product.should_receive(:self_update!)
      end
      receiver.self_update!
    end

    it 'returns a valid receiver' do
      receiver.self_update!
      receiver.should be_valid
    end

    it 'returns self if self_update! success' do
      new_receiver = receiver.dup
      new_receiver.self_update!
      new_receiver.should be_like receiver
    end

    it 'raises exception if self_update! fails' do
      receiver.stub(:self_update!).and_raise("StandardError")
      expect { receiver.self_update! }.to raise_error
    end

    it 'raises exception if user_receiver is nil' do
      receiver.offer.user_receiver = nil
      expect { receiver.self_update! }.to raise_error
    end

    it 'raises exception if user_receiver is not correct' do
      user = Fabricate.build(:user)
      receiver.offer.user_receiver = user
      user.destroy
      expect { receiver.self_update! }.to raise_error
    end

    context 'When offer is published' do
      before { receiver.offer.publish }

      it 'calls reload method' do
        receiver.should_receive(:reload)
        receiver.self_update!
      end

      it 'save changes' do
        receiver.should_receive(:save)
        receiver.self_update!
      end
    end

    context 'When offer is not published' do
      it 'does not call reload method' do
        receiver.should_not_receive(:reload)
        receiver.self_update!
      end

      it 'does not save changes' do
        receiver.should_not_receive(:save)
        receiver.self_update!
      end
    end
  end
=end
end
