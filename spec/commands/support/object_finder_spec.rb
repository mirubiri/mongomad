require 'spec_helper'

describe ObjectFinder do
  # Variables

  # Methods
  describe '#initialize(pattern_object)' do
    context 'when pattern_object is not nil' do
      let(:object_finder) { ObjectFinder.new(pattern_object) }

      it 'uses given pattern_object' do
        expect(object_finder.object).to eq pattern_object
      end

      it 'creates an instance of ObjectFinder' do
        expect(object_finder).to be_instance_of ObjectFinder
      end
    end

    context 'when pattern_object is nil' do
      let(:object_finder) { ObjectFinder.new(nil) }

      it 'returns nil' do
        expect(object_finder).to eq nil
      end
    end
  end

  describe '#execute(object)' do
    context 'when object is an user' do
      pending 'calls request where with user'
      pending 'calls offer where with user'
      pending 'calls negotiation where with user'
      pending 'calls deal where with user'
      context 'when user has related documents' do
        pending 'returns array of documents'
      end
      context 'when user does not have any related documents' do
        pending 'return nil (or an empty array)'
      end
    end
    context 'when object is an item' do
      pending 'calls offer where with item'
      pending 'calls negotiation where with item'
      pending 'calls deal where with item'
      context 'when item has related documents' do
        pending 'returns array of documents'
      end
      context 'when item does not have any related documents' do
        pending 'return nil (or an empty array)'
      end
    end
  end
end
