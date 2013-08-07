require 'spec_helper'

describe Sheet do
  # xlet(:offer) { Fabricate(:offer) }
  # xlet(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  # xlet(:proposal) { negotiation.proposals.last }
  # xlet(:receiver) { proposal.receiver }
  # xlet(:product) { receiver.products.last }

  # describe 'Includes' do
  #   xit 'include ImageManager::ImageHolder'
  # end

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_sheet }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
  #   xit { should have_denormalized_fields(:name, :description, :image_fingerprint).from('thing') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :polymorphic_sheet }
  #   it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  #   it { should validate_presence_of :quantity }
  #   it { should validate_numericality_of(:quantity).to_allow(nil: false,
  #                                                            only_integer: true,
  #                                                            greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
  #   specify { expect(product).to be_valid }

  #   it 'creates one negotiation' do
  #     expect { product.save }.to change{ Negotiation.count }.by(1)
  #   end
  end

  # describe '#thing' do
  #   subject { product.thing }

  #   xit { should be_instance_of(User::Thing) }

  #   xit 'returns thing which originated this product' do
  #     expect(subject.id).to eq product.thing_id
  #   end
  # end
end
