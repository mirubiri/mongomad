require 'spec_helper'

describe Offer do
  describe 'Relations' do
    it { should embed_one :composer }
    it { should embed_one :receiver }
    it { should embed_one :money }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:initial_message).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    it { should validate_presence_of :initial_message }
  end

  describe 'Factory' do
    let (:offer) { Fabricate(:offer) }
    specify { offer.should be_valid }
    specify { offer.save.should be_true }
  end

  describe '#composer_name' do
    xit 'Returns the offer\'s composer name'
  end

  describe '#composer_name=(name)' do
    xit 'Changes the offer\'s composer name to the given text|composer_name'
    xit 'Cannot change the offer\'s composer name with an invalid text|composer_name'
    xit 'Saves the current offer with offer\'s composer name changed'
  end

  describe '#receiver_name' do
    xit 'Returns the offer\'s receiver name'
  end

  describe '#receiver_name=(name)' do
    xit 'Changes the offer\'s receiver name to the given text|receiver_name'
    xit 'Cannot change the offer\'s receiver name with an invalid text|receiver_name'
    xit 'Saves the current offer with offer\'s receiver name changed'
  end

  describe '#initial_message' do
    xit 'Returns the offer\'s initial_message'
  end

  describe '#initial_message=(message)' do
    xit 'Changes the offer\'s initial_message to the given text|initial_message'
    xit 'Cannot change the offer\'s initial_message with an invalid text|initial_message'
    xit 'Saves the current offer with offer\'s initial_message changed'
  end

  #Elegir una de las dos siguientes
  describe '#user_composer' do
    xit 'Returns user who composes the offer'
  end

  describe '#user_composer_id' do
    xit 'Returns the id of the user who composes the offer'
  end

  #Elegir una de las dos siguientes
  describe '#user_receiver' do
    xit 'Returns user who receives the offer'
  end

  describe '#user_receiver_id' do
    xit 'Returns the id of the user who receives the offer'
  end

  describe '#composer_products' do
    xit 'Returns the composer\'s products'
  end

  describe '#receiver_products' do
    xit 'Returns the receiver\'s products'
  end

  describe '#add_composer_product(product)' do
    xit 'Add the given product to the composer\'s products'
    ## no añadir si no es bueno?
    ## salvar la current offer whit blablabla??? (como en los casos de arriba?)
  end

  describe '#publish' do
    it 'Saves a valid request' do
      request=Fabricate.build(:request)
      request.publish.should be_true
    end
    it 'Cannot save a not valid request' do
      request=Fabricate.build(:request,text:nil)
      request.publish.should be_false
    end
  end

  describe '#unpublish' do
    it 'Deletes a saved request' do
      request=Fabricate(:request)
      quantity=Request.count
      request.unpublish
      quantity.should be > Request.count
    end
    it 'Cannot delete a not saved request' do
      request=Fabricate.build(:request)
      quantity=Request.count
      request.unpublish
      quantity.should eq Request.count
   end
  end
end