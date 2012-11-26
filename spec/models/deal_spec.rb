require 'spec_helper'

describe Deal do
  #let(:deal) { Fabricate.build(:deal) }
  #after(:each) { deal && deal.destroy }

  describe 'Relations' do
    it { should embed_one(:agreement).of_type(Deal::Agreement) }
    it { should embed_many(:messages).of_type(Deal::Message) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
  end

=begin
  describe 'Factories' do
    specify { deal.should be_valid }
    specify { deal.save.should be_true }
  end
=end
end