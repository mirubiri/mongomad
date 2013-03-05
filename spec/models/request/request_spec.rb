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
    let(:new_request) do
      new_request = Request.generate(request_params)
    end

    it 'generates a request with the correct given parameters' do
      new_request.text = request.text
    end

    it 'generates a request with nil value for not given parameters' do
      new_request.user = nil
      new_request.user_name = nil
      new_request.image_name = nil
    end

    it 'does not persist the request' do
      new_request.should_not be_persisted
    end
  end

  describe '#publish' do
    context 'When request is not published' do

      context 'When request is valid' do
        it 'returns true' do
          request.publish.should eq true
        end

        it 'adds the request to requests collection' do
          request.publish
          Request.all.to_a.should include(request)
        end

        it 'adds the request to user' do
          request.publish
          User.find(request.user).requests.should include(request)
        end
      end

      context 'When request is not valid' do
        before { request.stub(:valid?).and_return(false) }

        it 'returns false' do
          request.publish.should eq false
        end

        it 'does not add the request to requests collection' do
          request.publish
          Request.all.to_a.should_not include(request)
        end

        it 'does not add the request to user' do
          request.publish
          User.find(request.user).requests.should_not include(request)
        end
      end
    end

    context 'When request is published' do
      it 'raises an exception' do
        request.publish
        expect { request.publish }.to raise_error
      end

      xit 'does not create a new request' do
        request.publish
        expect { request.publish }.to_not change { Request.count }
      end
    end
  end

  describe '#unpublish' do
    context 'When request is published' do
      before { request.publish }

      it 'returns true' do
        request.unpublish.should eq true
      end

      it 'removes the request from the collection' do
        request.unpublish
        Request.all.to_a.should_not include(request)
      end

      it 'removes the request from requests for user' do
        request.unpublish
        User.find(request.user).requests.should_not include(request)
      end

      it 'does not remove the image' do
        request.unpublish
        File.exist?(File.new(request.image.path)).should eq true
      end
    end

    context 'When request is not published' do
      it 'raises an error if unpublish the request' do
        expect { request.unpublish }.to raise_error
      end

      xit 'does not delete any request' do
        expect { request.unpublish }.to_not change { Request.count }
      end
    end
  end

  describe '#alter_contents(request_params)' do
    it 'returns true if given parameters are correct' do
      expect { request.alter_contents(request_params) }.to eq true
    end

    it 'returns false if given parameters are not correct' do
      request_params.delete(:text)
      expect { request.alter_contents(request_params) }.to eq false
    end

    it 'returns a request with modified parameters' do
      new_request = Fabricate.build(:request, user:user)
      new_request.should_not be_like request
      new_request.alter_contents(request_params)
      new_request.should be_like request
    end

    it 'returns a valid request' do
      new_request = Fabricate.build(:request, user:user)
      new_request.alter_contents(request_params)
      new_request.should be_valid
    end

    context 'When request is published' do
      before { request.publish }

      it 'checks request is saved after call alter_contents' do
        request.alter_contents(request_params)
        request.should be_persisted
      end

      it 'checks image is saved after call alter_contents' do
        request.alter_contents(request_params)
        File.exist?(File.new(request.image.path)).should eq true
      end

      it 'checks request is included in the collection' do
        request.alter_contents(request_params)
        Request.all.to_a.should include(request)
      end

      it 'checks request is included in the requests for user' do
        request.alter_contents(request_params)
        User.find(request.user).requests.should include(request)
      end
    end

    context 'When request is not published' do
      before do
        request.publish
        request.unpublish
      end

      it 'checks request is not saved after call alter_contents' do
        request.alter_contents(request_params)
        request.should_not be_persisted
      end

      it 'checks image is not saved after call alter_contents if user does not exist' do
        request.user.destroy
        request.user.persisted?.should eq false
        request.alter_contents(request_params)
        File.exist?(File.new(request.image.path)).should eq false
      end

      it 'checks image is saved after call alter_contents if user exists' do
        request.user.persisted?.should eq true
        request.alter_contents(request_params)
        File.exist?(File.new(request.image.path)).should eq true
      end

      it 'checks request is not included in the collection' do
        request.alter_contents(request_params)
        Request.all.to_a.should_not include(request)
      end

      it 'checks request is not included in the requests for user' do
        request.alter_contents(request_params)
        User.find(request.user).requests.should_not include(request)
      end
    end
  end

  describe '#self_update!' do
    let(:new_request) do
      new_request = Request.generate(request_params)
      new_request.user = request.user
    end

    it 'calls reload method' do
      new_request.should_receive(:reload)
      new_request.self_update!
    end

    it 'returns self it self_update! success' do
      new_request.self_update!
      new_request.should eq request
    end

    it 'returns error if self_update! fails' do
      new_request.user = nil
      expect { new_request.self_update! }.to raise_error
    end

    it 'returns a valid request' do
      new_request.self_update!
      new_request.should be_like request
    end

    it 'returns a request with updated parameters' do
      new_request.self_update!
      new_request.should be_valid
    end

    context 'When request is published' do
      before do
        request.publish
        new_request = Fabricate.build(:request)
        request.alter_contents(params_for_request(new_request))
        request.user = new_request.user
      end

      it 'checks request is saved after call self_update!' do
        request.self_update!
        request.should be_persisted
      end

      it 'checks image is saved after call self_update!' do
        request.self_update!
        File.exist?(File.new(request.image.path)).should eq true
      end

      it 'checks request is included in the collection' do
        request.self_update!
        Request.all.to_a.should include(request)
      end

      it 'checks request is included in the requests for user' do
        request.self_update!
        User.find(request.user).requests.should include(request)
      end
    end

    context 'When request is not published' do
      before do
        request.publish
        request.unpublish
        new_request = Fabricate(:request)
        #request.alter_contents(params_for_request(new_request))
         request.alter_contents(request_params)
        request.user = new_request.user
      end

      it 'checks request is not saved after call self_update!' do
        request.self_update!
        request.should_not be_persisted
      end

      it 'checks image is not saved after call self_update! if user does not exist' do
        request.user.destroy
        request.user.exist?.should eq false
        request.self_update!
        File.exist?(File.new(request.image.path)).should eq false
      end

      it 'checks image is saved after call self_update! if user exists' do
        request.user.exist?.should eq true
        request.self_update!
        File.exist?(File.new(request.image.path)).should eq true
      end

      it 'checks request is not included in the collection' do
        request.self_update!
        Request.all.to_a.should_not include(request)
      end

      it 'checks request is not included in the requests for user' do
        request.self_update!
        User.find(request.user).requests.should_not include(request)
      end
    end
  end
end
