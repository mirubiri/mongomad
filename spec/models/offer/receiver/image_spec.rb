require 'spec_helper'

describe Offer::Receiver::Product::Image do
  #let(:image) { Fabricate.build(:image) }
  #after(:each) do
  #  image.destroy
  #end

  describe 'Relations' do
    it { should be_embedded_in(:product).of_type(Offer::Receiver::Product) }
  end

  describe 'Attributes' do
    # TODO: ¿Validar campo 'file' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :product }
    it { should validate_presence_of :file }
  end

=begin
  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
    specify { expect(image.save).to be_true }
  end
=end
end