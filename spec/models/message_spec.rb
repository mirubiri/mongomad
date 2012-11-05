#Modules
require 'spec_helper'

describe Message do

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_message }
    it { should embed_one :photo }
  end

  describe 'Attributes' do
    it { should have_field(:sender_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:sender_complete_name,
                            :text)
                            .of_type(String) }
    it { should have_field(:sending_date).of_type(DateTime) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :photo }
    #Attributes
    it { should validate_presence_of :sender_id }
    it { should validate_presence_of :sender_complete_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :sending_date }
  end

  #Behaviour
  describe 'Factory' do
    let (:message) { Fabricate(:message) }
    specify { message.should be_valid }
  end

end