require 'spec_helper'

describe Offer::Receiver::Product::Image do
  let(:image) { Fabricate.build(:offer).receiver.products[0].secondary_images[0] }

  describe 'Relations' do
    it { should be_embedded_in(:product).of_type(Offer::Receiver::Product) }
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
