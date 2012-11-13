require 'spec_helper'

describe Request do
  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:requester_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :requester_id }
    it { should validate_presence_of :text }
  end

  describe 'Factory' do
    let (:request) { Fabricate(:request) }
    specify { request.should be_valid }
    specify { request.save.should be_true }
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
    it 'delete a saved request' do
      request=Fabricate(:request)
      request.unpublish.should be_true
    end
    it 'not delete a not saved request' do
      request=Fabricate.build(:request)
      request.unpublish.should be_false
   end
  end
end