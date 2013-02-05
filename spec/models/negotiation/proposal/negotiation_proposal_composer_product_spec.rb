require 'spec_helper'

describe Negotiation::Proposal::Composer::Product do
  let(:product) do
    Fabricate.build(:negotiation).proposals.last.composer.products.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:composer).of_type(Negotiation::Proposal::Composer) }
   end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:image).of_type(Object) }
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

    it 'Creates one negotiation' do
      expect { product.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      product.save
      File.exist?(File.new(product.image.path)).should be_true
    end
  end

  describe '#to_deal_agreement_proposal_composer_product' do
    it { should respond_to(:to_deal_agreement_proposal_composer_product).with(0).arguments }

    specify { product.to_deal_agreement_proposal_composer_product.should be_kind_of(Deal::Agreement::Proposal::Composer::Product) }

    it 'Builds an deal_agreement_proposal_composer_product' do
      aux_product = product.to_deal_agreement_proposal_composer_product
      product.thing_id.should eql aux_product.thing_id
      product.name.should eql aux_product.name
      product.description.should eql aux_product.description
      product.quantity.should eql aux_product.quantity
    end
  end
end
