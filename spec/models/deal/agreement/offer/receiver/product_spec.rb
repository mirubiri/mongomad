require 'spec_helper'

describe Deal::Agreement::Offer::Receiver::Product do
  #let(:product) { Fabricate.build(:product) }
  #after(:each) { product && product.polymorphic_product.polymorphic_composer.destroy }

  describe 'Relations' do
    it { should be_embedded_in(:receiver).of_type(Deal::Agreement::Offer::Receiver) }
    it { should embed_one(:secondary_image).of_type(Deal::Agreement::Offer::Receiver::Product::Image) }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:quantity).of_type(Integer).with_default_value_of(1) }
    # TODO: ¿Validar campo 'main_image' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :secondary_image }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :main_image }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

=begin
  describe 'Factories' do
    specify { product.should be_valid }
    specify { product.save.should be_true }
    it 'main_image must be saved on disk' do
      product.save
      expect(File.exists?(product.main_image.file.path)).to be_true
    end
  end

  describe '#destroy' do
    it 'deletes main_image files from disk' do
      file_path=product.main_image.file.path
      product.save
      product.destroy
      expect(File.exists?(file_path)).to be_false
    end
  end
=end
end