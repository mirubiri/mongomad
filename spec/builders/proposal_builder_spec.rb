require 'spec_helper'

describe ProposalBuilder do
	let(:builder) { ProposalBuilder.new }
	let(:composer) { Fabricate.build(:user) }
	let(:receiver) { Fabricate.build(:user) }
	let(:item) { Fabricate(:item) }
	let(:product) { item.to_product }
	let(:cash) { Fabricate.build(:cash,user_id:composer.id)}
	let(:goods) { [{id:item.id,_type:'Product'},{user_id:cash.user_id,amount:cash.amount,_type:'Cash'}] }

	let(:filled_builder) do
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

	describe '#build' do
		specify { expect(offer.composer_id).to eq composer.id }
		specify { expect(offer.receiver_id).to eq receiver.id }
		specify { expect(offer.goods).to include(product) }
		specify { expect(offer.goods).to include(cash) }
	end
 end
