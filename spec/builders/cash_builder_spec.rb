require 'spec_helper'

describe CashBuilder do
	let(:cash) { Fabricate.build(:cash) }
	let(:user) { Fabricate(:user) }
	let(:cash_params) { {id:'cash', user_id:user.id,amount:'100$'} }
	let(:builder) { CashBuilder.new }
	let(:filled_builder) { builder.user(user).amount(cash_params[:amount]) }
	let(:cash) { filled_builder.build }

	describe '#user(user)' do
		specify { expect(builder.user user).to eq builder }
	end

	describe '#amount(string)' do
		specify { expect(builder.amount cash_params[:amount]).to eq builder }
	end

	describe '#build' do
		specify { expect(cash.id).to eq 'cash' }
		specify { expect(cash.amount).to eq cash_params[:amount] }
		specify { expect(cash.user_id).to eq cash_params[:user_id] }
	end
end