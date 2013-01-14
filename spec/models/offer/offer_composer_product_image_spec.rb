require 'spec_helper'

describe Offer::Composer::Product::Image do
  let(:image) do
    Fabricate.build(:offer).composer.products.last.images.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:product).of_type(Offer::Composer::Product) }
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
