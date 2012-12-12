require 'spec_helper'

describe Deal::Agreement::Proposal::Receiver::Product::Image do
  let(:image) { Fabricate.build(:deal).agreement.proposals[0].receiver.products[0].secondary_images[0] }

  describe 'Relations' do
    it { should be_embedded_in(:product).of_type(Deal::Agreement::Proposal::Receiver::Product) }
  end

  describe 'Attributes' do
    # TODO: ¿Validar campo 'file' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :product }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
    specify { expect(image.save).to be_true }
  end
end
