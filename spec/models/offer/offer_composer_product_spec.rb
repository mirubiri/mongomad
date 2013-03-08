require 'spec_helper'

describe Offer::Composer::Product do
  let(:product) do
    Fabricate.build(:offer).composer.products.last
  end

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
      new_product = product.dup
    end

    it 'returns self it self_update! success' do
      new_product.self_update!
      new_product.should be_like product
    end

    it 'raise error if self_update! fails' do
      new_product.thing_id = nil
      expect { new_product.self_update! }.to raise_error
    end

    it 'returns a valid product' do
      new_product.self_update!
      new_product.should be_valid
    end

    it 'updates product name with the current composer_thing name' do
      User.find(new_product.composer.offer.user_composer).things.find(new_product.thing_id).stub(:name).and_return('updated')
      new_product.self_update!
      new_product.name.should eq 'updated'
    end

    it 'updates product description with the current composer_thing description' do
      User.find(new_product.composer.offer.user_composer).things.find(new_product.thing_id).stub(:description).and_return('updated')
      new_product.self_update!
      new_product.description.should eq 'updated'
    end

    it 'updates product image_name with the current composer_thing image_name' do
      User.find(new_product.composer.offer.user_composer).things.find(new_product.thing_id).stub(:image_name).and_return('updated.png')
      new_product.self_update!
      new_product.description.should eq 'updated.png'
    end

    context 'When product(offer) is published' do
      before { new_product.composer.offer.publish }

      it 'calls reload method' do
        new_product.should_receive(:reload)
        new_product.self_update!
      end

      it 'save the changes' do
        new_product.should_receive(:save)
        new_product.self_update!
      end
    end

    context 'When product(offer) is not published' do
      it 'does not save the changes' do
        new_product.should_not_receive(:save)
        new_product.self_update!
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
