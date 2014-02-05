require 'spec_helper'

describe ObjectFinder do
  # Variables

  # Methods
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
