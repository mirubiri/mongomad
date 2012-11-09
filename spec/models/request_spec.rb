require 'spec_helper'

describe Request do
  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :text }
  end

  describe 'Factory' do
    let (:request) { Fabricate.build(:request) }
    specify { request.should be_valid }
    specify { request.save.should be_true }
  end

  describe '#publish' do
    it 'saves a valid request' do
      request=Fabricate(:request)
      request.publish.should be_true
    end
    it 'not saves a request without a text' do
      request=Fabricate(:request,text:nil)
      request.publish.should be_false
    end
  end

  describe '#modify' do
  end

  describe '#unpublish' do
  end
end