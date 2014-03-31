require 'spec_helper'

class Test::A
  include Mongoid::Document
  embeds_one :b
end

class Test::B
  include Mongoid::Document
  embedded_in :a
  embeds_one :c
end

class Test::C
  include Mongoid::Document
  embedded_in :b
end

describe BaseValidator do

  let(:document) do
    document=Test::A.new
    document.build_b
    document.b.build_c
    document
  end

  let(:validator) { BaseValidator.new }
  let(:wrapped_document) { validator.base=base }

  describe '.new' do
    context 'no params' do
      it 'returns a new instance' do
        expect(BaseValidator.new).to be_an_instance_of(BaseValidator)
      end
    end

    context 'given a document' do
      it 'creates a new instance' do
        expect(BaseValidator.new document ).to be_an_instance_of(BaseValidator)
      end

      it 'sets document as the base document' do
        document=BaseValidator.new document
        expect(document.base).to eq document
      end
    end

    context 'not given a document' do
      it 'raise ArgumentError exception' do
        expect {BaseValidator.new(String.new)}.to raise_error ArgumentError
      end
    end
  end

  describe 'When a method is called' do

    context 'the method will make the base document invalid' do
      before do
        document.stub(:valid?).and_return(false)
        document.stub(:invalid_method)
      end

      it 'returns false' do
        expect(wrapped_document.invalid_method).to eq false
      end

      it 'do not call the method on target document' do
        expect{document}.to_not receive(:invalid_method)
        wrapped_document.invalid_method
      end
    end

    context 'the method will make the base document valid' do
      before do
        document.stub(:valid?).and_return true
        document.stub(:valid_method)
      end

      it 'calls the method on target document' do
        expect{document}.to receive(:valid_method)
        wrapped_document.valid_method
      end

      it 'returns the result of calling method on target document' do
        expect(wrapped_document.valid_method).to eq document.valid_method
      end
    end
  end

  describe '#base' do
    it 'return the document'

  end

end
