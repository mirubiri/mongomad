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
    end
    it 'generates a request with nil value for not given parameters' do
    end
    it 'does not persist the request' do
    end
  end

  describe '#publish' do
    context 'When request is published' do
      it 'checks request is persisted' do
      end
      it 'checks image is persisted' do
      end
      it 'raise an error if publish the request' do
      end
      it 'does not create a new request' do
      end
    end

    context 'When request is not published' do
      it 'checks request is not persisted' do
      end
      it 'checks image is not persisted if user does not exist' do
      end
      it 'checks image is persisted if user exists' do
      end

      context 'When request is valid' do
        it 'checks the request is valid' do
        end
        it 'returns true' do
        end
        it 'persists the request' do
        end
        it 'persists the image' do
        end
        it 'adds the request to the collection' do
        end
        it 'adds the request to requests for user' do
        end
      end

      context 'When request is not valid' do
        it 'checks the request is not valid' do
        end
        it 'returns false' do
        end
        it 'does not persist the request' do
        end
        it 'does not persist the image if user does not exist' do
        end
        it 'checks image is persisted if user exists' do
        end
        it 'does not add the request to the collection' do
        end
        it 'does not add the request to requests for user' do
        end
      end
    end
  end

  describe '#unpublish' do
    context 'When request is published' do
      it 'checks request is persisted' do
      end
      it 'checks image is persisted' do
      end
      it 'returns true' do
      end
      it 'removes the request from the collection' do
      end
      it 'removes the request from requests for user' do
      end
      it 'does not remove the image' do
      end
    end

    context 'When request is not published' do
      it 'checks request is not persisted' do
      end
      it 'checks image is not persisted if user does not exist' do
      end
      it 'checks image is persisted if user exists' do
      end
      it 'raise an error if unpublish the request' do
      end
      it 'does not delete any request' do
      end
    end
  end

  describe '#alter_contents(request_params)' do
    it 'returns true if given parameters are correct' do
    end
    it 'returns false if given parameters are not correct' do
    end
    it 'returns a request with modified parameters' do
    end
    it 'returns a valid request' do
    end

    context 'When request is published' do
      it 'checks request is persisted before call alter_contents' do
      end
      it 'checks image is persisted before call alter_contents' do
      end
      it 'checks request is persisted after call alter_contents' do
      end
      it 'checks image is persisted after call alter_contents' do
      end
      it 'checks request is included in the collection' do
      end
      it 'checks request is included in the requests for user' do
      end
    end

    context 'When request is not published' do
      it 'checks request is not persisted before call alter_contents' do
      end
      it 'checks image is not persisted before call alter_contents if user does not exist' do
      end
      it 'checks image is persisted before call alter_contents if user exists' do
      end
      it 'checks request is not persisted after call alter_contents' do
      end
      it 'checks image is not persisted after call alter_contents if user does not exist' do
      end
      it 'checks image is persisted after call alter_contents if user exists' do
      end
      it 'checks request is not included in the collection' do
      end
      it 'checks request is not included in the requests for user' do
      end
    end
  end

  describe '#self_update!' do
    it 'calls reload method' do
    end
    it 'returns true it self_update! success' do
    end
    it 'returns error if self_update! fails' do
    end
    it 'returns a request with updated parameters' do
    end
    it 'returns a valid request' do
    end

    context 'When request is published' do
      it 'checks request is persisted before call self_update!' do
      end
      it 'checks image is persisted before call self_update!' do
      end
      it 'checks request is persisted after call self_update!' do
      end
      it 'checks image is persisted after call self_update!' do
      end
      it 'checks request is included in the collection' do
      end
      it 'checks request is included in the requests for user' do
      end
    end

    context 'When request is not published' do
      it 'checks request is not persisted before call self_update!' do
      end
      it 'checks image is not persisted before call self_update! if user does not exist' do
      end
      it 'checks image is persisted before call self_update! if user exists' do
      end
      it 'checks request is not persisted after call self_update!' do
      end
      it 'checks image is not persisted after call self_update! if user does not exist' do
      end
      it 'checks image is persisted after call self_update! if user exists' do
      end
      it 'checks request is not included in the collection' do
      end
      it 'checks request is not included in the requests for user' do
      end
    end
  end
end
