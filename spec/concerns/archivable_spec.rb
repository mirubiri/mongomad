require 'spec_helper'

class Test::Archivable
	include Mongoid::Document
	include Archivable
end

describe Archivable do
	let(:document_class) { Test::Archivable }
  subject(:document) { document_class.new }

  it 'scopes all queries to archived=false' do
  	expect(document_class.criteria.selector).to eq({"archived"=>false})
  end

  it { is_expected.to have_field(:archived).of_type(Boolean).with_default_value_of(false) }

  describe '#archive' do
  	context 'document is persisted' do
  		before(:each) { document.save }

  		it 'sets the document as archived in the database' do
  			document.archive
  			expect(document.reload.archived?).to eq true
  		end

  		it 'returns true' do
  			expect(document.archive).to eq true
  		end
  	end

  	context 'document is not persisted' do
  		it 'returns false' do
  			expect(document.archive).to eq false
  		end

  		it 'does not save the document' do
  			document.archive
  			expect(document).to_not be_persisted
  		end
  	end
  end
end