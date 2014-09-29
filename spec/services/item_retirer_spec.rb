require 'rails_helper'

describe ItemRetirer do
  let(:id_list) { ['1','2','3'] }
  let(:product_query) { ProductQuery.new(id_list) }
  let(:retirer) { ItemRetirer.new(id_list) }

  describe '#retire' do
    it 'retire all products with the given ids' do 
      allow(product_query).to receive(:find) { 3.times.map { Fabricate.build(:product) } }
      products=product_query.find
      expect(products).to all( receive(:update_attributes).with(retired:true) )
      retirer.retire
    end
  end
  
end
