require 'spec_helper'

describe OfferBuilder do

	let(:proposal_builder) { ProposalBuilder.new }

	let(:builder) { OfferBuilder.new(proposal_builder:proposal_builder) }
	let(:composer) { Fabricate.build(:user) }
	let(:receiver) { Fabricate.build(:user) }
	let(:item) { Fabricate(:item) }
	let(:product) { item.to_product }
	let(:cash) { Fabricate.build(:cash,user_id:composer.id)}
	let(:goods) { [{id:item.id},{id:'cash',user_id:cash.user_id,amount:cash.amount}] }

	let!(:filled_builder) do
		builder.composer(composer).receiver(receiver).goods(goods).message('message')
	end

	let(:offer) { filled_builder.build }

	describe '#composer(user)' do
		specify { expect(builder.composer composer).to eq builder }
	end

	describe '#receiver(user)' do
		specify { expect(builder.receiver receiver).to eq builder }
	end

	describe '#goods(goods)' do
		specify { expect(builder.goods goods).to eq builder }
	end

	describe '#message(message)' do
		specify { expect(builder.message 'message').to eq builder }
	end

	describe '#reset' do
		specify { expect(filled_builder.reset).to eq true }
	end

	describe '#build' do
		specify { expect(offer.composer).to eq composer.sheet }
		specify { expect(offer.receiver).to eq receiver.sheet }
		specify { expect(offer.user_ids).to include(composer.id) }
		specify { expect(offer.user_ids).to include(receiver.id) }
		specify { expect(offer.message).to eq 'message'}
		specify { expect(offer.proposal).to equal proposal_builder.build }

		context 'After reset' do
			let!(:new_offer) { Offer.new }
			before(:each) { allow(Offer).to receive(:new).and_return(new_offer) }

			it 'returns a new offer' do
				filled_builder.reset
				expect(filled_builder.build).to eq new_offer
			end

			it 'calls reset on proposal_builder' do
				expect(proposal_builder).to receive(:reset)
				filled_builder.reset
			end
		end
	end
end
