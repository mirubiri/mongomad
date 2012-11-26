require 'spec_helper'

describe Offer do
  #let(:offer) { Fabricate.build(:offer) }
  #after(:each) { offer && offer.destroy }

  describe 'Relations' do
    it { should embed_one(:composer).of_type(Offer::Composer) }
    it { should embed_one(:receiver).of_type(Offer::Receiver) }
    it { should embed_one(:money).of_type(Offer::Money) }
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

=begin
  describe 'Factories' do
    specify { offer.should be_valid }
    specify { offer.save.should be_true }
  end
=end
end