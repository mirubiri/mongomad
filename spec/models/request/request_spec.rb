require 'spec_helper'

describe Request do
  let(:user) { Fabricate(:user) }
  let(:request) { Fabricate.build(:request, user:user) }
  let(:request_params) { params_for_request(request) }

  describe 'Relations' do
    it { should belong_to(:user) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(request.valid?).to eq true }
    specify { expect(request.save).to eq true }

    it 'creates one user' do
      expect { request.save }.to change{ User.count }.by(1)
    end
  end

  describe 'On save' do
    it 'has an image' do
      request.save
      File.exist?(File.new(request.image.path)).should eq true
    end
  end

  describe '.generate(request_params)' do
    it 'generates a request with the correct given parameters' do
      new_request = Request.generate(request_params)
      new_request.text = request.text
    end
  end

  describe '#publish' do
    context 'When request is valid' do
      it 'returns true' do
        request.publish.should eq true
      end

      it 'saves the request' do
        request.publish
        Request.all.to_a.should include(request)
      end

      it 'adds the request to requests for user' do
        request.publish
        User.find(request.user).requests.should include(request)
      end
    end

    context 'When request is not valid' do
      before { request.should_receive(:save).and_return(false) }

      it 'returns false' do
        request.publish.should eq false
      end

      it 'does not save the request' do
        request.publish
        Request.all.to_a.should_not include(request)
      end

      it 'does not add the request to requests for user' do
        request.publish
        User.find(request.user).requests.should_not include(request)
      end
    end

    context 'When request is published' do
      before { request.publish }

      it 'returns true' do
        request.publish.should eq true
      end

      it 'does not create a new request' do
        expect { request.publish }.to_not change { Request.count }
      end
    end
  end

  describe '#unpublish' do
    before do
      request.publish
      request.unpublish
    end

    context 'When request is saved' do
      it 'returns true' do
        request.unpublish.should eq true
      end

      it 'removes the request' do
        Request.all.to_a.should_not include(request)
      end

      it 'removes the request from requests for user' do
        User.find(request.user).requests.should_not include(request)
      end

      it 'does not remove image' do
        request.image.file.should be_exists
      end
    end

    context 'When request is not saved' do
      it 'returns true' do
        request.unpublish.should eq true
      end
    end
  end

  describe '#alter_contents(request_params)' do

    it 'calls to request.alter_contents with request_params' do
      request.should_receive(:alter_contents).with(request_params)
      request.alter_contents(request_params)
    end

    it 'returns a request with modified with request_params' do
      new_request=Fabricate.build(:request,user:user)
      new_request.alter_contents(request_params)
      new_request.should be_like request
    end
    specify { expect(request.alter_contents(request_params)).to eq true }
  end

  describe '#self_update!' do
    let(:new_request) do
      new_request = Request.generate(request_params)
      new_request.user = request.user
      new_request.self_update!
    end

    it 'returns a valid request after update it' do
      new_request.should be_valid
    end

    it 'returns a request corresponding to the given parameters' do
      new_request.should be_like request
    end

    it 'calls reload if persisted' do
      request.publish
      request.should_receive(:reload)
      request.self_update!
    end

    it 'does not call reload if not persisted' do
      request.should_not_receive(:reload)
      request.self_update!
    end

    it 'returns self if self_update! success' do
      request.self_update!.should eq request
    end

    it 'raise error if self_update! fails' do
      request.stub(:self_update!).and_raise("StandardError")
      expect { request.self_update! }.to raise_error
    end
  end
end
