require 'spec_helper'

describe Composer do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_composer }
    it { should embed_many :products }
  end

  describe 'Attributes' do
    it { should have_field(:composer_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:composer_name).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_composer }
    it { should validate_presence_of :products }
    it { should validate_presence_of :composer_id }
    it { should validate_presence_of :composer_name }
  end

  describe 'Factory' do
    let (:composer) { Fabricate(:composer) }
    specify { composer.should be_valid }
    specify { composer.save.should be_true }
  end
end