require 'spec_helper'

describe ImageBuilder do
	let(:builder) { ImageBuilder.new }
	let(:x) { 1 }
	let(:y) { 2 }
	let(:w) { 3 }
	let(:h) { 4 }
	let(:item_id) { 'item_id' }
	let(:main) { true }

	let!(:filled_builder) do
		builder.x(x).y(y).h(h).w(w).main(main).id(item_id)
	end

	let(:image) { filled_builder.build }

	describe '#x(point_x)' do
		specify { expect(builder.x x).to eq builder }
	end

	describe '#y(point_y)' do
		specify { expect(builder.y y).to eq builder }
	end

	describe '#h(height)' do
		specify { expect(builder.h h).to eq builder }
	end

	describe '#w(width)' do
		specify { expect(builder.w w).to eq builder }
	end

	describe '#main(main)' do
		specify { expect(builder.main main).to eq builder }
	end

	describe '#id(item_id)' do
		specify { expect(builder.id item_id).to eq builder }
	end

	describe '#reset' do
		specify { expect(builder.reset).to eq true}
	end

	describe '#build' do
		specify { expect(image.x).to eq x }
		specify { expect(image.y).to eq y }
		specify { expect(image.h).to eq h }
		specify { expect(image.w).to eq w }
		specify { expect(image.id).to eq item_id }
		specify { expect(image.main).to eq main }

		context 'After reset' do
			let(:new_image) { Attachment::Image.new }
			before(:each) do
				Attachment::Image.stub(:new).and_return(new_image)
				filled_builder.reset
			end
			it 'returns a new item' do
				expect(filled_builder.build).to eq new_image
			end
		end
	end
end