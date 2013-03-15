require 'spec_helper'

describe Offer::Composer do
  let(:offer) { Fabricate.build(:offer,
    user_composer:Fabricate(:user_with_things),
    user_receiver:Fabricate(:user_with_things))
  }
  let(:composer) { offer.composer }
  let(:products_params) { params_for_offer(offer)[:composer_things] }
  let(:thing) { User.where('things._id' => Moped::BSON::ObjectId(products_params.first[:thing_id])).first.things.find(products_params.first[:thing_id]) }

  describe 'Relations' do
    it { should be_embedded_in :offer }
    it { should embed_many(:products).of_type(Offer::Composer::Product) }
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
    specify { expect(composer.valid?).to eq true }

    it 'creates one offer' do
      expect { composer.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      composer.save
      File.exist?(File.new(composer.image.path)).should eq true
    end
  end

  describe '#add_products(products_params)' do
    let(:new_composer) do
      new_composer = offer.composer.clone
      new_composer.products.destroy
      new_composer.add_products(products_params)
    end

    it 'generates a composer with a list of products with correct value for given parameters' do
      new_composer.products.each_with_index do |product, index|
        product.thing_id.should eq products_params[index][:thing_id]
        product.quantity.should eq products_params[index][:quantity]
      end
    end

    it 'generates a composer with a list of products with nil value for not given parameters' do
      new_composer.products.each do |product|
        product.name.should eq nil
        product.description.should eq nil
        product.image_name.should eq nil
      end
    end

    it 'does not persist the composer' do
      new_composer.should_not be_persisted
    end

    it 'raises exception if any thing_id parameter is nil' do
      products_params.first[:thing_id] = nil
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'raises exception if any thing_id parameter does not belong to user_composer' do
      user = Fabricate.build(:user_with_things)
      products_params.first[:thing_id] = user.things.last._id
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'raises exception if any quantity parameter is nil' do
      products_params.first[:quantity] = nil
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'raises exception if any quantity parameter is negative' do
      products_params.first[:quantity] = -1
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'raises exception if any quantity parameter is higher than stock' do
      products_params.first[:quantity] = thing.stock + 1
      expect { composer.add_products(products_params) }.to raise_error
    end
  end

  describe '#alter_contents(products_params)' do
    it 'removes current list of products' do
      composer.products.should_receive(:destroy)
      composer.alter_contents(products_params)
    end

    it 'add a new list of products from given parameters' do
      composer.should_receive(:add_products).with(products_params)
      composer.alter_contents(products_params)
    end
  end

  describe '#self_update!' do
    let(:new_composer) { offer.composer }

    it 'returns a composer with a valid list of products' do
      new_composer.products.destroy
      new_composer.add_products(products_params)
      new_composer.products.should be_like composer.products
    end

    it 'updates composer name with current user_composer name' do
      composer.offer.user_composer.profile.stub(:name).and_return('updated')
      composer.self_update!
      composer.name.should eq 'updated'
    end

    it 'updates composer image_name with current user_composer image_name' do
      composer.offer.user_composer.profile.stub(:image_name).and_return('updated.png')
      composer.self_update!
      composer.image_name.should eq 'updated.png'
    end

    it 'updates product name for all products in the list with correct value' do
      composer.products.each do |product|
        thing = User.where('things._id' => Moped::BSON::ObjectId(product.thing_id)).first.things.find(products[:thing_id])
        composer.self_update!
        product.name.should eq thing.name
      end
    end

    it 'updates product description for all products in the list with correct value' do
      composer.products.each do |product|
        thing = User.where('things._id' => Moped::BSON::ObjectId(product.thing_id)).first.things.find(products[:thing_id])
        composer.self_update!
        product.description.should eq thing.description
      end
    end

    it 'updates product image_name for all products in the list with correct value' do
      composer.products.each do |product|
        thing = User.where('things._id' => Moped::BSON::ObjectId(product.thing_id)).first.things.find(products[:thing_id])
        composer.self_update!
        product.image_name.should eq thing.image_name
      end
    end

    it 'calls update_user_data method' do
      composer.should_receive(:update_user_data)
      composer.self_update!
    end

    it 'calls update_products method' do
      composer.should_receive(:update_products)
      composer.self_update!
    end

    it 'calls self_update! method for each product' do
      composer.products.each do |product|
        product.should_receive(:self_update!)
      end
      composer.self_update!
    end

    it 'returns a valid composer' do
      composer.self_update!
      composer.should be_valid
    end

    it 'returns self if self_update! success' do
      new_composer.self_update!
      new_composer.should be_like composer
    end

    it 'raises exception if user_composer is nil' do
      composer.offer.user_composer = nil
      expect { composer.self_update! }.to raise_error
    end

    it 'raises exception if user_composer is not correct' do
      user = Fabricate.build(:user)
      composer.offer.user_composer = user
      user.destroy
      expect { composer.self_update! }.to raise_error
    end

    context 'When offer is published' do
      before { composer.offer.publish }

      it 'calls reload method' do
        composer.should_receive(:reload)
        composer.self_update!
      end

      it 'save changes' do
        composer.should_receive(:save)
        composer.self_update!
      end
    end

    context 'When offer is not published' do
      it 'does not call reload method' do
        composer.should_not_receive(:reload)
        composer.self_update!
      end

      it 'does not save changes' do
        composer.should_not_receive(:save)
        composer.self_update!
      end
    end
  end
end
