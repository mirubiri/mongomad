require 'spec_helper'

describe User::Thing::Image do
  let(:user) { Fabricate.build(:user).things << Fabricate.build(:user_thing).secondary_images << Fabricate.build(:user_thing_image) }
  let(:image) { user.things.last.secondary_images[0] }


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
