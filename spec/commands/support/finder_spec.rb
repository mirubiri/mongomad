require 'spec_helper'

describe Finder do
end
  # # Variables
  # let(:user) { Fabricate.build(:user_with_items) }
  # let(:request) { Fabricate.build(:request, user:user) }
  # let(:offer) { Fabricate.build(:offer, user_composer:user) }
  # let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  # let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }

  # # Methods
  # describe '#initialize(pattern_object)' do
  #   context 'when pattern_object is not nil' do
  #     let(:object_finder) { ObjectFinder.new(pattern_object) }

  #     it 'uses given pattern_object' do
  #       expect(object_finder.object).to eq pattern_object
  #     end

  #     it 'creates an instance of ObjectFinder' do
  #       expect(object_finder).to be_instance_of ObjectFinder
  #     end
  #   end

  #   context 'when pattern_object is nil' do
  #     let(:object_finder) { ObjectFinder.new(nil) }

  #     it 'returns nil' do
  #       expect(object_finder).to eq nil
  #     end
  #   end
  # end

  # describe '#execute()' do
  #   context 'when object to find is a user' do
  #     let(:object_finder) { ObjectFinder.new(user) }

  #     it 'searches user in Request collection' do
  #       expect(Request).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     it 'searches user in Offer collection' do
  #       expect(Offer).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     it 'searches user in Negotiation collection' do
  #       expect(Negotiation).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     it 'searches user in Deal collection' do
  #       expect(Deal).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     context 'when user has related documents' do
  #       before(:each) do
  #         request.save
  #         offer.save
  #         negotiation.save
  #         deal.save
  #       end

  #       let(:related_documents) do
  #         related_documents = Array.new
  #         related_documents << request
  #         related_documents << offer
  #         related_documents << negotiation
  #         related_documents << deal
  #         related_documents
  #       end

  #       it 'returns an array' do
  #         expect(object_finder.execute()).to be_instance_of Array
  #       end

  #       it 'returns related documents' do
  #         expect(object_finder.execute()).to eq related_documents
  #       end
  #     end

  #     context 'when user does not have any related documents' do
  #       it 'returns nil' do
  #         expect(object_finder.execute()).to eq nil
  #       end
  #     end
  #   end

  #   context 'when object to find is a user' do
  #     let(:object_finder) { ObjectFinder.new(user) }

  #     it 'searches user in Request collection' do
  #       expect(Request).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     #TODO: Meter todo esto en un shared_example
  #     it 'searches user in Offer collection' do
  #       expect(Offer).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     it 'searches user in Negotiation collection' do
  #       expect(Negotiation).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     it 'searches user in Deal collection' do
  #       expect(Deal).to receive(:where).with(user)
  #       object_finder.execute()
  #     end

  #     context 'when user has related documents' do
  #       before(:each) do
  #         request.save
  #         offer.save
  #         negotiation.save
  #         deal.save
  #       end

  #       it 'returns an array' do
  #         expect(object_finder.execute()).to be_instance_of Array
  #       end

  #       it 'returns related documents' do
  #         expect(object_finder.execute()).to eq related_documents
  #       end
  #     end

  #     context 'when user does not have any related documents' do
  #       it 'returns nil' do
  #         expect(object_finder.execute()).to eq nil
  #       end
  #     end
  #   end
  # end
# end
