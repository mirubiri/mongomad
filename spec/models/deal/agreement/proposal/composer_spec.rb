require 'spec_helper'

describe Deal::Agreement::Proposal::Composer do
  #let(:composer) { Fabricate.build(:composer) }
  #after(:each) { composer && composer.polymorphic_composer.destroy }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:products).of_type(Deal::Agreement::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:composer_name).of_type(String) }
    # TODO: ¿Validar campo 'image' (Paperclip)?
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :composer_id }
    it { should validate_presence_of :composer_name }
    it { should validate_presence_of :image }
  end

=begin
  describe 'Factories' do
    specify { composer.should be_valid }
    specify { composer.save.should be_true }
    it 'image must be saved on disk' do
      composer.save
      expect(File.exists?(composer.image.file.path)).to be_true
    end
  end

  describe '#destroy' do
    it 'deletes image files from disk' do
      file_path=composer.image.file.path
      composer.save
      composer.destroy
      expect(File.exists?(file_path)).to be_false
    end
  end
=end
end