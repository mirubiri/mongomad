require 'spec_helper'

describe OfferBuilder do

	let(:builder) { OfferBuilder.new }
	let(:composer) { Fabricate.build(:user) }
	let(:receiver) { Fabricate.build(:user) }
	let(:item) { Fabricate(:item) }
	let(:product) { item.to_product }
	let(:cash) { Fabricate.build(:cash,user_id:composer.id)}
	let(:goods) { [{id:item.id,_type:'Product'},{user_id:cash.user_id,amount:cash.amount,_type:'Cash'}] }

	let(:filled_builder) do
		builder.composer(composer).receiver(receiver).goods(goods).message('message')
	end

	let(:proposal) { builder.instance_variable_get(:@proposal_builder).build }
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

	describe '#build' do
		specify { expect(offer.composer).to eq composer.sheet }
		specify { expect(offer.receiver).to eq receiver.sheet }
		specify { expect(offer.user_ids).to include(composer.id) }
		specify { expect(offer.user_ids).to include(receiver.id) }
		specify { expect(offer.message).to eq 'message'}
		specify { expect(offer.proposal).to equal proposal }
	end
end
