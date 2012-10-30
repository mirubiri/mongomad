#Modules
require 'spec_helper'

describe Thing do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :user }
    it { should embed_one(:main_photo).of_type(Photo) }
    it { should embed_many(:photos) }
  end

  #Attributes
  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_fields(:name,
                            :description)
                            .of_type(String) }
    it { should have_field(:stock).of_type(Integer).with_default_value_of(1) }
  end

  #Validations
  describe 'Validations' do
    #Relations
    it { should validate_presence_of :main_photo }
    #Attributes
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }

    it { should validate_numericality_of(:stock).to_allow(nil:false,
                                                          only_integer:true,
                                                          greater_than_or_equal_to:0) }
  end

  #Behaviour
  describe 'Factory' do
    pending("TODO: Factory")
  end

end

=begin
#Behaviour
  before (:all) do
    @thing=Fabricate(:thing)
    @product=@thing.to_product
  end

  describe 'Factory' do
    specify { @thing.should be_valid }
  end

  describe '#owner' do
    it 'return the user owner id' do
      @thing.owner.should eq @thing.thing_box.user
    end
  end

  describe '#to_product' do
    describe '=> product' do
#No dan un texto descriptivo
      specify { @product.should be_kind_of(Product) }
      specify { @product.should_not be_persisted }
      specify { @product.name.should eq @thing.name }
      specify { @product.description.should eq @thing.description }
      specify { @product.main_photo.should eq @thing.main_photo }
      specify { @product.thing_id.should eq @thing._id }
      specify { @product.quantity.should be_nil }
      specify { @product.photos.should eq @thing.photos }
    end
  end
=end
