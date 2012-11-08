require 'spec_helper'

describe Receiver do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_receiver }
    it { should embed_many :products }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_receiver }
    it { should validate_presence_of :products }
    it { should validate_presence_of :user_id }
  end


  describe 'Factory' do
    let (:receiver) { Fabricate.build(:receiver) }
    specify { receiver.should be_valid }
    specify { receiver.save.should be_true }
  end
end