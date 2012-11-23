require 'spec_helper'

describe Receiver do
  let(:receiver) { Fabricate.build(:receiver) }

  describe 'Relations' do
    it { should be_embedded_in :receiver_parent }
    it { should embed_many :products }
    it { should embed_one :photo}

  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :receiver_parent }
    it { should validate_presence_of :products }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :photo }
  end

  describe 'Factories' do
    specify { receiver.should be_valid }
    specify { receiver.save.should be_true }
  end
end