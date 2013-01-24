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
    specify { expect(thing.valid?).to be_true }

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

  describe '#to_product(quantity)' do
    it { should respond_to(:to_product).with(1).arguments }
    specify { thing.to_product(1).should_be kind_of("Offer::Product") }

    it 'Builds an offer_product with the given quantity' do
      product = thing.to_product(1)
      product.name.should eql thing.name
      product.description.should eql thing.description
      product.thing_id.should eql thing._id
      product.quantity.should eql 1
    end

    it 'Cannot build a product with quantity greater than stock' do
      expect { thing.to_product(product.stock+1) }.to raise_error
    end

    it 'Cannot build a product with 0 or negative quantity' do
      expect { thing.to_product(0).to raise_error }
      expect { thing.to_product(-1).to raise_error }
    end
  end
end
