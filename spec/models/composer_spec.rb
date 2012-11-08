require 'spec_helper'

describe Composer do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_composer }
    it { should embed_many :products }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:full_name).of_type(String) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :polymorphic_composer }
    it { should validate_presence_of :products }
    #Attributes
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :full_name }
  end


  describe 'Factory' do
    let (:composer) { Fabricate.build(:composer) }
    specify { composer.should be_valid }
  end
end