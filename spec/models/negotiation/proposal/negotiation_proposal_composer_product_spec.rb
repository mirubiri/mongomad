require 'spec_helper'

describe Negotiation::Proposal::Composer::Product do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:composer) { proposal.receiver }
  let(:product) { composer.products.last }

  describe 'Relations' do
    it { should be_embedded_in(:composer).of_type(Negotiation::Proposal::Composer) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
    it { should have_denormalized_fields(:name, :description, :image_name).from('thing') }
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
    specify { expect(product).to be_valid }

    it 'creates one negotiation' do
      expect { product.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      product.save
      expect(File.exist? product.image.path).to eq true
    end
  end

  describe '#thing' do
    subject { product.thing }

    it { should be_instance_of(User::Thing) }

    it 'returns thing which originated this product' do
      expect(subject.id).to eq product.thing_id
    end
  end
end
