require 'spec_helper'

describe User::Thing::Image do
  let(:image) do
    Fabricate.build(:user_with_things).things.last.images.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:thing).of_type(User::Thing) }
  end

  describe 'Attributes' do
    # TODO: ¿Validar campo 'file' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :thing }
    it { should validate_presence_of :file }
  end

  describe 'Factories' do
    specify { expect(image.valid?).to be_true }
  end
end
