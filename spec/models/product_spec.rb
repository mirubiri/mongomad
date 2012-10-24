require 'spec_helper'

describe Product do

  describe 'Embedded' do
    it { should be_embedded_in :product_box }
  end

  describe 'Associated' do
  end

  describe 'Validations' do
    xit { should validate_presence_of :main_photo_url }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :thing_id }
    it { should validate_numericality_of(:quantity).to_allow(greater_than:0,only_integer:true,nil:false) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    xit { should have_field(:main_photo_url) }
    xit { should have_field(:photos_url).of_type(Array) }

    it { should have_field(:quantity).of_type(Integer).with_default_value_of(1) }
    it { should have_field(:thing_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:name,:description).of_type(String) }
  end

  describe 'Factory' do
   let (:product) { Fabricate.build(:product) }
    specify { product.should be_valid }
  end
end
