=begin
require 'spec_helper'

describe Image do
  let(:image) { Fabricate.build(:image) }
  after(:each) do
    image.destroy
  end
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_image }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_image }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
    specify { expect(image.save).to be_true }
  end
end
