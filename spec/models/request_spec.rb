require 'spec_helper'

describe Request do
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
    let (:request) { Fabricate(:request) }
    specify { request.should be_valid }
    specify { request.save.should be_true }
  end

  describe '#restate(text)' do
    xit 'Changes the request to the given text'
    xit 'Cannot change the request with an invalid text'
    xit 'Saves the current request'
  end

  describe '#requester' do
    xit 'Returns the requester'
  end

  describe '#publish' do
    it 'saves a valid request' do
      request=Fabricate.build(:request)
      request.publish.should be_true
    end
    it 'not saves a not valid request' do
      request=Fabricate.build(:request,text:nil)
      request.publish.should be_false
    end
  end

  describe '#unpublish' do
    it 'deletes the request' do
      request=Fabricate(:request)
      qty=Request.count
      request.unpublish
      qty.should be > Request.count
    end
    it 'not deletes a not saved request' do
      request=Fabricate.build(:request)
      qty=Request.count
      request.unpublish
      qty.should eq Request.count
   end
  end
end