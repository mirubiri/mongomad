require 'spec_helper'

describe Offer::Composer::Product do
  let(:user_composer) { Fabricate(:user_with_things) }
  let(:user_receiver) { Fabricate(:user_with_things) }
  let(:offer) { Fabricate.build(:offer, user_composer:user_composer, user_receiver:user_receiver) }
  let(:composer) { offer.composer }
  let(:product) { composer.products.last }
  let(:thing) { user_composer.things.last }
  let(:product_params) { params_for_offer(offer)[:composer_things].first }

  describe 'Relations' do
    it { should be_embedded_in(:composer).of_type(Offer::Composer) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
    it { should have_denormalized_fields :name, :description, :quantity, :image_name }
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

  describe 'after_save' do
    it 'has an image' do
      product.save
      File.exist?(File.new(product.image.path)).should eq true
    end
  end

=begin

  describe '.generate(params)' do
    it_should_behave_like ".generate", %w(thing_id quantity) do
      let(:new_instance) { Offer::Composer::Product.generate(product_params) }
      let(:params) { product_params }
    end
  end

  describe '#alter_contents(params)' do
    it_should_behave_like '#alter_contents', %w(quantity) do
      let(:instance) { product }
      let(:params) do
        product_params[:quantity]+=1
        product_params
      end
    end
  end


  describe '#self_update' do
    it 'updates product name with current thing name' do
      product.self_update!
      product.name.should eq thing.name
    end

    it 'updates product description with current thing description' do
      product.self_update!
      product.description.should eq thing.description
    end

    it 'updates product image_name with current thing image_name' do
      product.self_update!
      product.image_name.should eq thing.image_name
    end

    it 'returns a valid product' do
      product.self_update!
      product.should be_valid
    end

    it 'returns self if self_update! success' do
      new_product = Fabricate.build(:offer).composer.products.last
      new_product.composer = product.composer
      new_product.thing_id = product.thing_id
      new_product.quantity = product.quantity
      new_product.self_update!
      new_product.should be_like product
    end

    it 'raises exception if thing_id parameter is nil' do
      product.thing_id = nil
      expect { product.self_update! }.to raise_error
    end

    it 'raises exception if thing_id parameter is not correct' do
      product.thing_id = Fabricate.build(:user_with_things).things.last._id
      expect { product.self_update! }.to raise_error
    end

    context 'When offer is published' do
      before { product.composer.offer.publish }

      it 'calls reload method' do
        product.should_receive(:reload)
        product.self_update!
      end

      it 'save changes' do
        product.should_receive(:save)
        product.self_update!
      end
    end

    context 'When offer is not published' do
      it 'does not call reload method' do
        product.should_not_receive(:reload)
        product.self_update!
      end

      it 'does not save changes' do
        product.should_not_receive(:save)
        product.self_update!
      end
    end
  end
=end
end
