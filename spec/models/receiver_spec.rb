#Modules
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
    #Relations
    it { should validate_presence_of :polymorphic_receiver }
    it { should validate_presence_of :products }
    #Attributes
    it { should validate_presence_of :user_id }
  end

  #Behaviour
  #describe 'Factory' do
  #  let (:receiver) { Fabricate.build(:receiver) }
  #  specify { receiver.should be_valid }
  #end
end