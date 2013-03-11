require 'spec_helper'

describe Offer::Composer::Product do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:composer) { offer.composer }
  let(:product) { composer.products.last }

  describe 'Relations' do
    it { should be_embedded_in(:composer).of_type(Offer::Composer) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :composer }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :image_name }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(product.valid?).to eq true }

    it 'creates one offer' do
      expect { product.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      product.save
      File.exist?(File.new(product.image.path)).should eq true
    end
  end

  describe '#self_update' do
    let(:new_product) do
      new_product = Offer::Composer::Product.new
      new_product.thing_id = product.thing_id
      new_product.quantity = thing.stock
      new_product
    end

    it 'returns self if self_update! success' do
      new_product.self_update!
      new_product.should be_like product
    end

    it 'raises error if self_update! fails' do
      product.thing_id = nil
      expect { product.self_update! }.to raise_error

      product.thing_id = user_receiver.things.last._id
      expect { product.self_update! }.to raise_error

      product.quantity = thing.stock + 1
      expect { product.self_update! }.to raise_error
    end

    it 'returns a valid product' do
      product.self_update!
      product.should be_valid
    end

    context 'When offer is published' do
      before { offer.publish }

      it 'updates product name with the current thing name' do
        composer.offer.user_composer.things.find(product.thing_id).stub(:name).and_return('updated')
        product.self_update!
        product.name.should eq 'updated'
      end

      it 'updates product description with the current thing description' do
        thing.stub(:description).and_return('updated')
        product.self_update!
        product.description.should eq 'updated'
      end

      it 'updates product image_name with the current thing image_name' do
        thing.stub(:image_name).and_return('updated.png')
        product.self_update!
        product.image_name.should eq 'updated.png'
      end

      it 'calls reload method' do
        product.should_receive(:reload)
        product.self_update!
      end

      it 'save the changes' do
        product.should_receive(:save)
        product.self_update!
      end
    end

    context 'When offer is not published' do
      it 'does not call reload method' do
        product.should_not_receive(:reload)
        product.self_update!
      end

      it 'does not save the changes' do
        product.should_not_receive(:save)
        product.self_update!
      end
    end
  end

=begin

  describe '#self_update' do
    before(:each) do
      thing = double('thing',:name =>'updated',:description => 'updated',:image_name =>'updated.png')
      product.composer.offer.user_composer.things.stub(:find).and_return(thing)
      product.self_update
    end
    it 'updates name' do
      product.name.should eq 'updated'
    end
    it 'updates description' do
      product.description.should eq 'updated'
    end
    it 'updates image_name' do
      product.image_name.should eq 'updated.png'
    end
  end
=end
end
