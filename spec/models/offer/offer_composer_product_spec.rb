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
    it { should validate_presence_of :image }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(product.valid?).to be_true, "Is not valid because #{product.errors}" }

    it 'Creates one offer' do
      expect { product.save }.to change{ Offer.count }.by(1)
    end
  end

  describe 'on save' do
    it 'Uploads an image' do
      product.save
      File.exist?(File.new(product.image.path)).should be_true
    end
  end

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

  #TODO: TODAS ESTAS FUNCIONES NO DEBERIAN SER PRIVADAS Y NO TESTEARSE?
end
