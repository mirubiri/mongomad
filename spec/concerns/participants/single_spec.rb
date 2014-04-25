require 'spec_helper'

class Test::ParticipantsSingle
	include Participants::Single
end

describe 'Participants::Single' do
	subject(:klass) { Test::ParticipantsSingle }

	it { should have_field :user_id }

	it 'raise error if Participants::Couple is included' do
		expect { klass.include Participants::Couple }.to raise_error
	end
end