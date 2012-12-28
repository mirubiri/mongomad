require 'spec_helper'

describe Negotiation::Proposal::Composer::Product::Image do
  let(:image) do
    Fabricate.build(:negotiation_proposal_composer_product_image, product:Fabricate.build(:negotiation_proposal_composer_product, composer:Fabricate.build(:negotiation_proposal_composer, proposal:Fabricate.build(:negotiation_proposal, negotiation:Fabricate.build(:negotiation)))))
  end

  describe 'Relations' do
    it { should be_embedded_in(:product).of_type(Negotiation::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:file).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :product }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
  end
end
