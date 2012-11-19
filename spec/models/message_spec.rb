require 'spec_helper'

describe Message do
  let(:message) { Fabricate.build(:message) }

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_message }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:sender_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:sender_name,
                            :text)
                            .of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_message }
    it { should validate_presence_of :sender_id }
    it { should validate_presence_of :sender_name }
    it { should validate_presence_of :text }
  end

  xit "Cada mensaje debe ir acompanado del avatar del usuario que lo escribe"

  describe 'Factory' do

    specify { message.should be_valid }
    specify { message.save.should be_true }
  end
end