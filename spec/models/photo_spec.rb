#Modules
require 'spec_helper'

describe Photo do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_photo }
  end

  #Attributes
  describe 'Attributes' do
    it { should be_timestamped_document }
    #TODO: ¿Poner tipos en los campos? ¿Campo con la foto adjunta?
    it { should have_fields(:photo_file_name,
                            :photo_file_size,
                            :photo_content_type) }
  end

  #Validations
  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :photo_file_name }
    it { should validate_presence_of :photo_file_size }
    it { should validate_presence_of :photo_content_type }
  end

  #Behaviour
  describe 'Factory' do
    let (:photo) { Fabricate.build(:photo) }
    specify { photo.should be_valid }
  end

end
