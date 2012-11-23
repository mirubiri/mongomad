require 'spec_helper'

describe Message do
  let(:message) { Fabricate.build(:message) }

  describe 'Relations' do
    it { should be_embedded_in :message_parent }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:sender_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:sender_name,
                            :text)
                            .of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :message_parent }
    it { should validate_presence_of :sender_id }
    it { should validate_presence_of :sender_name }
    it { should validate_presence_of :text }
  end

  xit "Cada mensaje debe ir acompanado del avatar del usuario que lo escribe"

  describe 'Factories' do

    specify { message.should be_valid }
    specify { message.save.should be_true }
  end
end