require 'spec_helper'

describe Request do
  let(:request) { Fabricate.build(:request) }
  include_context 'clean collections'

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:owner_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :owner_id }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :text }
  end

  describe 'Factories' do
    specify { request.should be_valid }
    specify { request.save.should be_true }
  end
end