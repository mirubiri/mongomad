require 'spec_helper'

describe Offer do
  describe 'Relations' do
    it { should embed_one :composer }
    it { should embed_one :receiver }
    it { should embed_one :money }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :initial_message }
  end

  describe 'Factory' do
    let (:offer) { Fabricate(:offer) }
    specify { offer.should be_valid }
    specify { offer.save.should be_true }
  end

  xit '#composer_name'
  xit '#composer_products'
  xit '#receiver_name'
  xit '#receiver_products'
  xit '#composer_user'
  xit '#receiver_user'
  xit '#publication_date'
  xit '#send'
  xit '#withdraw'
end