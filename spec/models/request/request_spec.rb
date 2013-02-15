require 'spec_helper'

describe Request do
  let(:request) do
    Fabricate.build(:request)
  end

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
    it { should validate_presence_of :image }
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

  describe '.generate(params=[])' do
    let(:request_params) do
      request.publish
      {
        user: request.user,
        text: request.text
      }
    end

    it 'generates a valid request given correct parameters' do
      Request.generate(request_params).should be_valid
    end

    describe 'Returned request' do
      let(:new_request) { Request.generate(request_params) }

      specify { new_request.user.should eql request_params[:user] }
      specify { new_request.user_name.should eql request.name }
      specify { new_request.text.should eql request_params[:text] }
      specify { new_request.image_name.should eql request.image_name }
    end
  end

  describe '#publish' do
    context 'When request is valid' do
      it 'returns true' do
        resquest.publish.should eq true
      end

      it 'saves the request' do
        request.publish
        Request.all.to_a.should include(request)
      end

      it 'adds the request to requests for user' do
        request.publish
        request.user.requests.should include(request)
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
        request.user.requests.should_not include(request)
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

  describe '#modify(params=[])' do
    xit 'Updates the request with the given params'
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

      it 'deletes the request' do
        Request.all.to_a.should_not include(request)
      end

      it 'removes the request from requests for user' do
        request.user.reload.request.should_not include(request)
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
end
