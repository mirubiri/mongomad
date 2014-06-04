require 'rails_helper'

describe RequestBuilder do

  let(:new_request) { Request.new }
  let(:builder) { RequestBuilder.new }
  let(:user) { Fabricate.build(:user) }
  let(:text) { 'text' }
  let!(:filled_builder) do
    builder.text(text)
      .user(user)
  end

  let(:request) { filled_builder.build }

  describe '#text(text)' do
    specify { expect(builder.text text).to eq builder }
  end

  describe '#user(user)' do
    specify { expect(builder.user user).to eq builder }
  end

  describe '#build' do
    specify { expect(request.text).to eq text }
    specify { expect(request.user).to eq user.sheet }
    specify { expect(request.user_id).to eq user.id }
  end

  describe '#reset' do
    it 'resets the builder' do
      allow(Request).to receive(:new).and_return(new_request)
      filled_builder.reset
      expect(filled_builder.build).to eq new_request
    end
  end
end
