require 'spec_helper'

describe Product do
  let(:product) { Fabricate.build(:product) }
  after(:each) { product && product.product_parent.composer_parent.destroy }

  describe 'Relations' do
    it { should be_embedded_in :product_parent }
    it { should embed_one :main_image }
  end

  describe 'Attributes' do
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:name,
                            :description)
                            .of_type(String) }
    it { should have_field(:quantity).of_type(Integer).with_default_value_of(1) }
  end

  describe 'Validations' do
    it { should validate_presence_of :product_parent }
    it { should validate_presence_of :thing_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :main_image }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).to_allow(nil: false,
                                                             only_integer: true,
                                                             greater_than_or_equal_to: 0) }
  end

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

end