require 'spec_helper'

describe Finder do
  # Variables
  let(:user) { Fabricate.build(:user_with_items) }
  let(:request) { Fabricate.build(:request, user:user) }
  let(:offer) { Fabricate.build(:offer, user_composer:user) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:object) { user.sheet }
  let(:collections) { [Request,Offer,Negotiation,Deal] }
  let(:related_documents) do
    related_documents = Array.new
    related_documents << request.user_sheet
    related_documents << offer.user_sheets.where(_id:user._id)
    related_documents << negotiation.user_sheets.where(_id:user._id)
    related_documents << deal.user_sheets.where(_id:user._id)
    related_documents
  end

  # Methods
  describe 'self.find(object, collections[])' do
    context 'when object and collections array are not empty' do
      it 'calls where method with object for every member' do
        collections.each do |member|
          expect(member).to receive(:where).with(object)
        end
        Finder.find(object, collections)
      end

      context 'when object has related documents' do
        it 'returns related documents' do
          user.save
          related_documents.each do |document|
            document.save
          end
          expect(Finder.find(object, collections)).to eq related_documents
        end
      end

      context 'when object has not related documents' do
        it 'returns an empty array' do
          expect(Finder.find(object, collections)).to eq Array.new
        end
      end
    end

    context 'when collections array is empty' do
      it 'returns an empty array' do
        expect(Finder.find(object, Array.new)).to eq Array.new
      end
    end
  end
end
