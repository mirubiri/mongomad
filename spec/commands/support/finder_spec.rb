require 'spec_helper'

describe Finder do
  # Variables
  let(:user) { Fabricate.build(:user_with_items) }
  let(:request) { Fabricate.build(:request, user:user) }
  let(:offer) { Fabricate.build(:offer, user_composer:user) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }

  # Methods
  describe 'self.find(object, collections[])' do
    context 'when object is a user_sheet' do
      let(:object) { user.sheet }
      let(:collections) { [Request, Offer, Negotiation, Deal] }

      context 'when object has related documents' do
        before(:each) do
          [user, request, offer, negotiation, deal].each do |document|
            document.save
          end
        end

        let(:matched_objets) do
          matched_objets = Array.new
          matched_objets << request.user_sheet
          matched_objets << offer.user_sheets.where(_id:object._id).first
          matched_objets << negotiation.user_sheets.where(_id:object._id).first
          matched_objets << deal.user_sheets.where(_id:object._id).first
          matched_objets
        end

        it 'returns an array with matched objects' do
          expect(Finder.find(object, collections)).to eq matched_objets
        end
      end

      context 'when object does not have related documents' do
        it 'returns an empty array' do
          expect(Finder.find(object, collections)).to eq Array.new
        end
      end
    end

    context 'when object is a product' do
      let(:object) { offer.proposal.goods.first }
      let(:collections) { [Offer, Negotiation, Deal] }

      context 'when object has related documents' do
        before(:each) do
          [user, offer, negotiation, deal].each do |document|
            document.save
          end
        end

        let(:matched_objets) do
          matched_objets = Array.new
          matched_objets << offer.proposal.goods.where(_id:object._id).first
          matched_objets << negotiation.proposal.goods.where(_id:object._id).first
          matched_objets << deal.agreement.goods.where(_id:object._id).first
          matched_objets
        end

        it 'returns an array with matched objects' do
          expect(Finder.find(object, collections)).to eq matched_objets
        end
      end

      context 'when object does not have related documents' do
        it 'returns an empty array' do
          expect(Finder.find(object, collections)).to eq Array.new
        end
      end
    end
  end
end
