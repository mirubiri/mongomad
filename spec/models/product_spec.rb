require 'spec_helper'

describe Product do
  # let(:offer) { Fabricate(:offer) }
  # let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  # let(:proposal) { negotiation.proposals.last }
  # let(:receiver) { proposal.receiver }
  # let(:product) { receiver.products.last }

  # describe 'Includes' do
  #   xit 'include ImageManager::ImageHolder'
  # end

  describe 'Relations' do
    it { should be_embedded_in :product_container }
    it { should embed_one(:sheet).of_type(ItemSheet) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:quantity).of_type(Integer) }
  #   it { should have_denormalized_fields(:name, :description, :image_fingerprint).from('thing') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :product_container }
    it { should validate_presence_of :sheet }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
  #   specify { expect(product).to be_valid }

  #   it 'creates one negotiation' do
  #     expect { product.save }.to change{ Negotiation.count }.by(1)
  #   end
  end

  # describe '#thing' do
  #   subject { product.thing }

  #   it { should be_instance_of(User::Thing) }

  #   it 'returns thing which originated this product' do
  #     expect(subject.id).to eq product.thing_id
  #   end
  # end
end
