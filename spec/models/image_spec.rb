require 'spec_helper'

describe Image do
  let(:image) { Fabricate.build(:image) }
  include_context 'clean collections'

  describe 'Relations' do
    it { should be_embedded_in :image_parent }
  end

  describe 'Validations' do
    it { should validate_presence_of :image_parent }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
    specify { expect(image.save).to be_true }
  end
end
