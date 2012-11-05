#Modules
require 'spec_helper'

describe Composer do

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_composer }
    it { should embed_many :products }
    it { should embed_one :photo }
  end

  describe 'Attributes' do
    it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_fields(:complete_name).of_type(String) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :products }
    it { should validate_presence_of :photo }
    #Attributes
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :complete_name }
  end

  #Behaviour
  describe 'Factory' do
    let (:composer) { Fabricate(:composer) }
    specify { composer.should be_valid }
  end

end