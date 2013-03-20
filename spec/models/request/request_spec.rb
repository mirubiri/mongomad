require 'spec_helper'

describe Request do
  let(:request) { Fabricate.build(:request, user:Fabricate(:user)) }
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
    it { should validate_length_of(:text).within(1..160) }
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
    let(:new_request) { Request.generate(request_params) }

    it 'generates a request with correct value for given parameters' do
      new_request.text.should eq request.text
    end

    it 'does not persist the request' do
      new_request.should_not be_persisted
    end
  end

  describe '#publish' do
    it 'publish a new request' do
      request.should_receive(:save)
      request.publish
    end

    it 'raises exception if request is currently published' do
      request.publish
      expect { request.publish }.to raise_error
    end
  end

  describe '#unpublish' do
    it 'removes a published request' do
      request.publish
      request.should_receive(:destroy)
      request.unpublish
    end

    it 'raises exception if request is currently unpublished' do
      expect { request.unpublish }.to raise_error
    end
  end

  describe '#alter_contents(request_params)' do
    let(:new_request) { request.clone }

    it 'modifies only text parameter when more parameters are given' do
      new_request.text = nil
      new_params = { text:request_params[:text], another:'another' }
      new_request.alter_contents(new_params).should be_like request
    end

    it 'returns an unmodified request when text parameter is not given' do
      new_params = { another:'another' }
      new_request.alter_contents(new_params).should be_like request
    end

    context 'When request is published' do
      it 'save changes' do
        request.publish
        request.should_receive(:save)
        request.alter_contents(request_params)
      end
    end

    context 'When request is not published' do
      it 'does not save changes' do
        request.should_not_receive(:save)
        request.alter_contents(request_params)
      end
    end
  end

  describe '#self_update!' do
    it 'updates request user_name with current user nickname' do
      request.user.profile.stub(:nickname).and_return('updated')
      request.self_update!
      request.user_name.should eq 'updated'
    end

    it 'updates request image_name with current user image_name' do
      request.user.profile.stub(:image_name).and_return('updated.png')
      request.self_update!
      request.image_name.should eq 'updated.png'
    end

    it 'returns a valid request' do
      request.self_update!
      request.should be_valid
    end

    it 'returns self if self_update! success' do
      new_request = Request.generate(request_params)
      new_request.user = request.user
      new_request.self_update!
      new_request.should be_like request
    end

    context 'When request is published' do
      before { request.publish }

      it 'calls reload method' do
        request.should_receive(:reload)
        request.self_update!
      end

      it 'saves changes' do
        request.should_receive(:save)
        request.self_update!
      end
    end

    context 'When request is not published' do
      it 'does not call reload method' do
        request.should_not_receive(:reload)
        request.self_update!
      end

      it 'does not save changes' do
        request.should_not_receive(:save)
        request.self_update!
      end
    end
  end
end
