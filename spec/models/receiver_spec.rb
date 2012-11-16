require 'spec_helper'

describe Receiver do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_receiver }
    it { should embed_many :products }
  end

  describe 'Attributes' do
    it { should have_field(:receiver_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:receiver_name).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_receiver }
    it { should validate_presence_of :products }
    it { should validate_presence_of :receiver_id }
    it { should validate_presence_of :receiver_name }
  end

  describe 'Factory' do
    let(:receiver) { Fabricate(:receiver) }
    specify { receiver.should be_valid }
    specify { receiver.save.should be_true }
  end
end