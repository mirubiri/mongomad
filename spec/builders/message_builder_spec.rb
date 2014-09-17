require 'rails_helper'

describe MessageBuilder do
  
  let(:builder) { MessageBuilder.new }
  let(:user) { Fabricate.build(:user) }
  let(:text) { 'a text message'}

  let(:message) do
    builder.user(user)
    builder.text(text)
    builder.build
  end


  describe '#user(user)' do
    it 'returns the builder' do
      expect(builder.user(user)).to eq builder
    end
  end

  describe '#text(string)' do
    it 'returns the builder' do
      expect(builder.text(text)).to eq builder
    end
  end

  describe '#build' do
    subject { message }
    it { is_expected.to be_a_kind_of Message }
    it { is_expected.to have_attributes(id:user.id,text:text) }
  end
  
end
