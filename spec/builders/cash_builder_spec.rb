require 'spec_helper'

describe CashBuilder do
	let(:cash) { Fabricate.build(:cash) }
	let(:user) { Fabricate(:user) }
	let(:cash_params) { {id:'cash', user_id:user.id,amount:'100$'} }
	let(:builder) { CashBuilder.new }
	let!(:filled_builder) { builder.user(user).amount(cash_params[:amount]) }
	let(:cash) { filled_builder.build }

	describe '#user(user)' do
		specify { expect(builder.user user).to eq builder }
	end

	describe '#amount(string)' do
		specify { expect(builder.amount cash_params[:amount]).to eq builder }
	end

	describe '#reset' do
		specify { expect(filled_builder.reset).to eq true }
	end

	describe '#build' do
		specify { expect(cash.id).to eq 'cash' }
		specify { expect(cash.amount).to eq cash_params[:amount] }
		specify { expect(cash.user_id).to eq cash_params[:user_id] }

		context 'After reset' do
			let(:new_cash) { Cash.new }
			before(:each) do
				Cash.stub(:new).and_return(new_cash)
				filled_builder.reset
			end
			it 'returns a new item' do
				expect(filled_builder.build).to eq new_cash
			end
		end
	end
end