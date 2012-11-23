require 'spec_helper'

describe ImageShadow do
  let(:image) { Fabricate.build(:image_shadow) }
  
  describe 'Relations' do
    it { should be_embedded_in :image_shadow_parent }
  end

  describe 'Validations' do
    it { should validate_presence_of :image_shadow_parent }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
    specify { expect(image.save).to be_true }
  end
end
