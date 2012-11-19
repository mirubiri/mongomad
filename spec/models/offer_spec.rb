require 'spec_helper'

describe Offer do
  let(:offer) { Fabricate(:offer) }

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
    specify { offer.should be_valid }
    specify { offer.save.should be_true }
  end
end