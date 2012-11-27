require 'spec_helper'

describe Deal::Message do
  #let(:message) { Fabricate.build(:message) }
  #after(:each) { message && message.polymorphic_message.destroy }

  describe 'Relations' do
    it { should be_embedded_in :deal }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:sender_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:sender_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    # TODO: ¿Validar campo 'image' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :deal }
    it { should validate_presence_of :sender_id }
    it { should validate_presence_of :sender_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

=begin
  describe 'Factories' do

    specify { message.should be_valid }
    specify { message.save.should be_true }
  end
=end
end