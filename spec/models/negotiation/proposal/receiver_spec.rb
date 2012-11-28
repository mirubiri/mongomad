require 'spec_helper'

describe Negotiation::Proposal::Receiver do
  #let(:receiver) { Fabricate.build(:receiver) }
  #after(:each) { receiver && receiver.polymorphic_receiver.destroy }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
    it { should embed_many(:products).of_type(Negotiation::Proposal::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:name).of_type(String) }
    # TODO: ¿Validar campo 'image' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
  end

=begin
  describe 'Factories' do
    specify { receiver.should be_valid }
    specify { receiver.save.should be_true }
    it 'image must be saved on disk' do
      receiver.save
      expect(File.exists?(receiver.image.file.path)).to be_true
    end
  end

  describe '#destroy' do
    it 'deletes image files from disk' do
      file_path=receiver.image.file.path
      receiver.save
      receiver.destroy
      expect(File.exists?(file_path)).to be_false
    end
  end
=end
end