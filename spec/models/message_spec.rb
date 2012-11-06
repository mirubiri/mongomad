#Modules
require 'spec_helper'

describe Message do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_message }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:sender_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:sender_full_name,
                            :text)
                            .of_type(String) }
  end

  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :sender_id }
    it { should validate_presence_of :sender_full_name }
    it { should validate_presence_of :text }
  end

  #Behaviour
  describe 'Factory' do
    let (:message) { Fabricate.build(:message) }
    specify { message.should be_valid }
  end
end