require 'spec_helper'

describe Image do
  let(:image) { Fabricate.build(:image) }

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_image }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_image }
    it { should validate_presence_of :file }
  end

  describe 'Factory' do
    specify { image.should be_valid }
    specify { image.save.should be_true }
  end
end
