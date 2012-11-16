require 'spec_helper'

describe Request do
  let(:request) { Fabricate(:request) }

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:owner_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:owner_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :owner_id }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :text }
  end

  describe 'Factory' do
    specify { request.should be_valid }
    specify { request.save.should be_true }
  end

  describe '#owner_name' do
    xit 'Returns the owner name'
  end

  describe '#owner_name=(name)' do
    xit 'Changes the owner name to the given name'
    xit 'Cannot change the owner name with an invalid name'
  end

  describe '#text' do
    xit 'Returns the request text'
  end

  describe '#text=(text)' do
    xit 'Changes the request text to the given text'
    xit 'Cannot change the request text with an invalid text'
  end

  describe '#user_owner' do
    xit 'Returns user who owns the request'
  end

  describe '#user_owner_id' do
    xit 'Returns the id of the user who owns the request'
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