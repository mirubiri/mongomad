require 'spec_helper'

describe Product do
  let(:product) { Fabricate.build(:product) }
  include_context 'clean collections'

  describe 'Relations' do
    it { should be_embedded_in :product_parent }
    it { should embed_many :secondary_images }
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
  end


end