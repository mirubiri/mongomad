#Modules
require 'spec_helper'

describe Photo do

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_photo }
  end

  describe 'Attributes' do
    #TODO: ¿Campo con la foto adjunta o campo string con url de la foto?
    it { should have_fields(:file_name,
                            :file_content_type,
                            :file_url)
                            .of_type(String) }
    it { should have_field(:file_size).of_type(Integer) }
  end

  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :file_name }
    it { should validate_presence_of :file_content_type }
    it { should validate_presence_of :file_url }
    it { should validate_presence_of :file_size }
    it { should validate_numericality_of(:file_size).to_allow(nil:false,
                                                              only_integer:true,
                                                              greater_than_or_equal_to:0) }
  end

  #Behaviour
  describe 'Factory' do
    let (:photo) { Fabricate.build(:photo) }
    specify { photo.should be_valid }
  end

end