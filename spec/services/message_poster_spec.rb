require 'rails_helper'

describe MessagePoster do
  describe '#post_message(message)' do

    let(:conversable) { Fabricate.build(:negotiation) }
    let(:message_poster) { MessagePoster.new(conversable) }
    let(:message) { Fabricate.build(:message,id:conversable.composer.id)}

    context 'user is authorized' do
      before(:example) { allow(conversable).to receive(:authorized?) { true } }

      context 'given a participant message' do
        before(:example) { allow(conversable).to receive(:participant?) { true } }
        it 'post the message into the conversable' do
          message_poster.post_message(message)
          expect(conversable.messages.last).to eq message
        end

        it 'returns true' do
          expect(message_poster.post_message(message)).to eq true
        end
      end
    end

    context 'user is not authorized' do
      before(:example) { allow(conversable).to receive(:authorized?) { false } }

      it 'do not post the message into the conversable' do
        expect{message_poster.post_message(message)}.not_to change{ conversable.messages }
      end

      it 'returns false' do
        expect(message_poster.post_message(message)).to eq false
      end
    end
  end
end
