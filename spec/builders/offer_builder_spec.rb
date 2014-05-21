require 'spec_helper'

describe OfferBuilder do
	let(:builder) { OfferBuilder.new }
	let(:composer) { Fabricate.build(:user) }
	let(:receiver) { Fabricate.build(:user) }
	let(:item) { Fabricate.build(:item) }
	let(:goods) { [{item.id,_type:'Product'},{user_id:composer.id,amount:100,_type:'Cash'}] }

	let(:filled_builder) do
		builder.composer(composer).receiver(receiver).goods(goods)
	end

	let(:offer) { filled_builder.build }

	describe '#composer(user)' do
		expect(builder.composer composer).to eq builder
	end

	describe '#receiver(user)' do
		expect(builder.receiver receiver).to eq builder
	end

	describe '#goods(goods)' do
		expect(builder.goods goods).to eq builder
	end

	describe '#build' do
		specify { expect(offer.composer).to eq composer.sheet }
		specify { expect(offer.receiver).to eq receiver.sheet }
		specify { expect(offer).goods to include(item.to_product) }
	end
 end
