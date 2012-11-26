require 'spec_helper'

describe Negotiation::Proposal do
  #let(:offer) { Fabricate.build(:offer) }
  #after(:each) { offer && offer.destroy }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_one(:composer).of_type(Negotiation::Proposal::Composer) }
    it { should embed_one(:receiver).of_type(Negotiation::Proposal::Receiver) }
    it { should embed_one(:money).of_type(Negotiation::Proposal::Money) }
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