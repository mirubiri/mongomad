require 'spec_helper'

describe ProductBox do


  describe 'Relations' do
    it { should be_embedded_in :polymorphic_product_box }
    it { should embed_many :products }
  end

  describe 'Attributes' do
  end

  describe 'Validations' do
    it { should validate_presence_of :products }
  end

  describe 'Factory' do
    let (:product_box) { Fabricate.build(:product_box) }
    specify { product_box.should be_valid }
  end
end
