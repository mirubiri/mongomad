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
      new_request.text.should eq request.text
    end

    it 'generates a request with nil value for not given parameters' do
      new_request.user.should eq nil
      new_request.user_name.should eq nil
      new_request.image_name.should eq nil
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

    it 'raise exception if request is currently published' do
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

    it 'raise exception if request is currently unpublished' do
      expect { request.unpublish }.to raise_error
    end
  end

  describe '#alter_contents(request_params)' do
    let(:new_request) do
      new_request = request.clone
    end

    it 'only modifies the text' do
      new_request.text = nil
      params = { text:request_params[:text], another:"another" }
      new_request.alter_contents(params).should be_like request
    end

    it 'returns an unmodified request when params does not include text' do
      params = { another:"another" }
      new_request.alter_contents(params).should be_like request
    end

    context 'When request is published' do
      it 'save the changes' do
        request.publish
        request.should_receive(:save)
        request.alter_contents(request_params)
      end
    end

    context 'When request is not published' do
      it 'does not save the changes' do
        request.should_not_receive(:save)
        request.alter_contents(request_params)
      end
    end
  end

  describe '#self_update!' do
    let(:new_request) do
      new_request = Request.generate(request_params)
      new_request.user = request.user
      new_request
    end

    it 'returns self it self_update! success' do
      new_request.self_update!
      new_request.should be_like request
    end

    it 'raise error if self_update! fails' do
      new_request.user = nil
      expect { new_request.self_update! }.to raise_error
    end

    it 'returns a valid request' do
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

      it 'calls reload method' do
        request.should_receive(:reload)
        request.self_update!
      end

      it 'save the changes' do
        request.should_receive(:save)
        request.self_update!
      end
    end

    context 'When request is not published' do
      it 'does not save the changes' do
        new_request = Fabricate.build(:request)
        request.alter_contents(params_for_request(new_request))
        request.user = new_request.user
        request.should_not_receive(:save)
        request.self_update!
      end
    end
  end
end
