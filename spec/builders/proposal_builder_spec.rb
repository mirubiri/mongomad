require 'rails_helper'

describe ProposalBuilder do
	let(:builder) { ProposalBuilder.new }
	let(:composer) { Fabricate.build(:user) }
	let(:receiver) { Fabricate.build(:user) }
	let(:item) { Fabricate(:item) }
	let(:product) { item.to_product }
	let(:cash) { Fabricate.build(:cash,user_id:composer.id)}
	let(:goods) { [{id:item.id},{id:'cash', user_id:cash.user_id,amount:cash.amount}] }

	let!(:filled_builder) do
		builder.composer(composer).receiver(receiver).goods(goods)
	end

	let(:offer) { filled_builder.build }

	describe '#composer(user)' do
		specify { expect(builder.composer(composer)).to eq builder }
	end

	describe '#receiver(user)' do
		specify { expect(builder.receiver(receiver)).to eq builder }
	end

	describe '#goods(goods)' do
		specify { expect(builder.goods(goods)).to eq builder }
	end

	describe '#reset' do
		specify { expect(filled_builder.reset).to eq true}
	end

	describe '#build' do
		specify { expect(offer.composer_id).to eq composer.id }
		specify { expect(offer.receiver_id).to eq receiver.id }
		specify { expect(offer.goods).to include(product) }
		specify { expect(offer.goods).to include(cash) }

		context 'After reset' do
			let(:new_proposal) { Proposal.new }
			before(:each) do
				allow(Proposal).to receive(:new).and_return(new_proposal)
				filled_builder.reset
			end
			it 'returns a new item' do
				expect(filled_builder.build).to eq new_proposal
			end
		end
	end
 end
