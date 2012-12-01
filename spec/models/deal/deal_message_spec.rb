require 'spec_helper'

describe Deal::Message do
  let(:message) { Fabricate.build(:deal).messages[0] }
  include_context 'clean collections'

  describe 'Relations' do
    it { should be_embedded_in :deal }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    # TODO: ¿Validar campo 'image' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :deal }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(message.valid?).to be_true }
    specify { expect(message.save).to be_true }
  end
end