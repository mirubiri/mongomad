require 'spec_helper'

describe User::Thing do
  let(:thing) do
    Fabricate.build(:user_with_things).things.last
  end

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:stock).of_type(Integer).with_default_value_of(1) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }
    it { should validate_presence_of :image }
    it { should validate_numericality_of(:stock).to_allow(nil: false,
                                                          only_integer: true,
                                                          greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(thing.valid?).to be_true, "Is not valid because #{thing.errors}" }

    it 'Creates one user' do
      expect { thing.save }.to change{ User.count }.by(1)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      thing.save
      File.exist?(File.new(thing.image.path)).should be_true
    end
  end

  describe '#to_offer_composer_product(quantity)' do
    it { should respond_to(:to_offer_composer_product).with(1).arguments }

    specify { thing.to_offer_composer_product(1).should be_kind_of(Offer::Composer::Product) }

    it 'Builds an offer_composer_product with the given quantity' do
      product = thing.to_offer_composer_product(1)
      product.thing_id.should eql thing._id
      product.name.should eql thing.name
      product.description.should eql thing.description
      product.quantity.should eql 1
    end

    it 'Cannot build an offer_composer_product with quantity greater than stock' do
      expect { thing.to_offer_composer_product(thing.stock+1) }.to raise_error(StandardError, "Not enough stock avaliable")
    end

    it 'Cannot build an offer_composer_product with 0 or negative quantity' do
      expect { thing.to_offer_composer_product(0) }.to raise_error(StandardError, "Quantity not valid")
      expect { thing.to_offer_composer_product(-1) }.to raise_error(StandardError, "Quantity not valid")
    end
  end

  describe '#to_offer_receiver_product(quantity)' do
    it { should respond_to(:to_offer_receiver_product).with(1).arguments }

    specify { thing.to_offer_receiver_product(1).should be_kind_of(Offer::Receiver::Product) }
    specify { thing.to_offer_receiver_product(1).valid?.should be_true, "Is not valid because #{generated_offer.errors}" }

    it 'Builds an offer_receiver_product with the given quantity' do
      product = thing.to_offer_receiver_product(1)
      product.thing_id.should eql thing._id
      product.name.should eql thing.name
      product.description.should eql thing.description
      product.quantity.should eql 1
    end

    it 'Cannot build an offer_receiver_product with quantity greater than stock' do
      expect { thing.to_offer_receiver_product(thing.stock+1) }.to raise_error(StandardError, "Not enough stock avaliable")
    end

    it 'Cannot build an offer_receiver_product with 0 or negative quantity' do
      expect { thing.to_offer_receiver_product(0) }.to raise_error(StandardError, "Quantity not valid")
      expect { thing.to_offer_receiver_product(-1) }.to raise_error(StandardError, "Quantity not valid")
    end
  end
end
