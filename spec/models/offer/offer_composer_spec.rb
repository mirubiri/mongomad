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
    it 'returns a composer with a list of products with correct value for given parameters' do
      composer.products.destroy
      composer.add_products(products_params)
      composer.products.each_with_index do |product, index|
        product.thing_id.should eq products_params[index][:thing_id]
        product.quantity.should eq products_params[index][:quantity]
      end
    end

    it 'returns a composer with a list of products with nil value for not given parameters' do
      composer.products.destroy
      composer.add_products(products_params)
      composer.products.each do |product|
        product.name.should eq nil
        product.description.should eq nil
        product.image_name.should eq nil
      end
    end

    it 'raises exception if any thing_id parameter is nil' do
      products_params.first[:thing_id] = nil
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'raises exception if any thing_id parameter does not belong to user_composer' do
      products_params.first[:thing_id] = Fabricate.build(:user_with_things).things.last._id
      expect { composer.add_products(products_params) }.to raise_error
    end

    it 'does not raise exception if any thing_id parameter does not exist' do
      products_params.first.delete(:thing_id)
      expect { composer.add_products(products_params) }.not_to raise_error
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

    it 'does not raise exception if any quantity parameter does not exist' do
      products_params.first.delete(:quantity)
      expect { composer.add_products(products_params) }.not_to raise_error
    end

    context 'When offer is published' do
      it 'saves changes' do
        composer.offer.publish
        # TODO: Revisar lo del 'target' (ALEJANDRO)
        composer.target.should_receive(:save)
        composer.add_products(products_params)
      end
    end

    context 'When offer is not published' do
      it 'does not save changes' do
        composer.should_not_receive(:save)
        composer.add_products(products_params)
      end
    end
  end

  describe '#alter_contents(products_params)' do
    xit 'modifies only correct parameters when more parameters are given' do
      new_params = products_params
      new_params.each do |product|
        product.merge!(another:'another')
      end
      composer.alter_contents(new_params)
      composer.products.each_with_index do |product, index|
        product.thing_id.should eq new_params[index][:thing_id]
        product.quantity.should eq new_params[index][:quantity]
      end
    end

    xit 'returns an unmodified composer when no correct parameters are given' do
      new_params = { another:'another' }
      new_composer = composer.clone
      new_composer.alter_contents(new_params)
      new_composer.products.should be_like composer.products
    end

    xit 'removes current list of products' do
      composer.products.should_receive(:destroy)
      composer.alter_contents(products_params)
    end

    xit 'add a new list of products to composer from given parameters' do
      composer.should_receive(:add_products).with(products_params)
      composer.alter_contents(products_params)
    end

    context 'When offer is published' do
      xit 'save the changes' do
        composer.offer.publish
        composer.should_receive(:save)
        composer.alter_contents(products_params)
      end
    end

    context 'When offer is not published' do
      xit 'does not save the changes' do
        composer.should_not_receive(:save)
        composer.alter_contents(products_params)
      end
    end
  end

  describe '#self_update!' do
    let(:new_composer) { offer.composer }

    xit 'updates composer name with current user_composer name' do
      composer.offer.user_composer.profile.stub(:name).and_return('updated')
      composer.self_update!
      composer.name.should eq 'updated'
    end

    xit 'updates composer image_name with current user_composer image_name' do
      composer.offer.user_composer.profile.stub(:image_name).and_return('updated.png')
      composer.self_update!
      composer.image_name.should eq 'updated.png'
    end

    xit 'updates product name for all products in the list with correct value' do
      composer.products.each do |product|
        thing = User.where('things._id' => Moped::BSON::ObjectId(product.thing_id)).first.things.find(products[:thing_id])
        composer.self_update!
        product.name.should eq thing.name
      end
    end

    xit 'updates product description for all products in the list with correct value' do
      composer.products.each do |product|
        thing = User.where('things._id' => Moped::BSON::ObjectId(product.thing_id)).first.things.find(products[:thing_id])
        composer.self_update!
        product.description.should eq thing.description
      end
    end

    xit 'updates product image_name for all products in the list with correct value' do
      composer.products.each do |product|
        thing = User.where('things._id' => Moped::BSON::ObjectId(product.thing_id)).first.things.find(products[:thing_id])
        composer.self_update!
        product.image_name.should eq thing.image_name
      end
    end

    xit 'calls update_user_data method' do
      composer.should_receive(:update_user_data)
      composer.self_update!
    end

    xit 'calls update_products method' do
      composer.should_receive(:update_products)
      composer.self_update!
    end

    xit 'calls self_update! method for each product' do
      composer.products.each do |product|
        product.should_receive(:self_update!)
      end
      composer.self_update!
    end

    xit 'returns a valid composer' do
      composer.self_update!
      composer.should be_valid
    end

    xit 'returns self if self_update! success' do
      new_composer.self_update!
      new_composer.should be_like composer
    end

    xit 'returns a valid list of products' do
      composer.products.destroy
      composer.add_products(products_params)
      composer.products.should be_valid
    end

    xit 'returns a composer with a valid list of products' do
      new_composer.products.destroy
      new_composer.add_products(products_params)
      new_composer.products.should be_like composer.products
    end

    xit 'raises exception if user_composer is nil' do
      composer.offer.user_composer = nil
      expect { composer.self_update! }.to raise_error
    end

    xit 'raises exception if user_composer is not correct' do
      user = Fabricate.build(:user)
      composer.offer.user_composer = user
      user.destroy
      expect { composer.self_update! }.to raise_error
    end

    context 'When offer is published' do
      before { composer.offer.publish }

      xit 'calls reload method' do
        composer.should_receive(:reload)
        composer.self_update!
      end

      xit 'save changes' do
        composer.should_receive(:save)
        composer.self_update!
      end
    end

    context 'When offer is not published' do
      xit 'does not call reload method' do
        composer.should_not_receive(:reload)
        composer.self_update!
      end

      xit 'does not save changes' do
        composer.should_not_receive(:save)
        composer.self_update!
      end
    end
  end
end
