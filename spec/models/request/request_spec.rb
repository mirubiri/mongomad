require 'spec_helper'

describe Request do
  let(:request) do
    Fabricate.build(:request)
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(request.valid?).to be_true }
    specify { expect(request.save).to be_true }
  end
end
