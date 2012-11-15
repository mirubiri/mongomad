require 'spec_helper'

describe Thing do
  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should have_fields(:name,
                            :description)
                            .of_type(String) }
    it { should have_field(:stock).of_type(Integer).with_default_value_of(1) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }
    it { should validate_numericality_of(:stock).to_allow(nil: false,
                                                          only_integer: true,
                                                          greater_than_or_equal_to: 0) }
  end

  describe 'Factory' do
    let (:thing) { Fabricate(:thing) }
    specify { thing.should be_valid }
    specify { thing.save.should be_true }
  end



  describe '#publish' do
    xit 'saves a valid thing' do
      thing=Fabricate.build(:thing)
      thing.publish.should be_true
    end
    xit 'not saves a not valid request' do
      thing=Fabricate.build(:thing,text:nil)
      thing.publish.should be_false
    end
  end

  describe '#unpublish' do
    xit 'deletes the current thing' do
      thing=Fabricate(:thing)
      qty=Thing.count
      thing.unpublish
      qty.should be > Thing.count
    end
    xit 'cannot delete an unsaved thing' do
     thing=Fabricate.build(:thing)
      qty=Thing.count
      thing.unpublish
      qty.should eq Thing.count
    end
  end

  describe '#sell_one' do
    context 'When stock is available' do
      xit 'decreases stock by one unit'
      xit 'returns true'
    end
    context 'When stock is 0' do
      xit 'returns false'
    end
  end

  describe '#sell(quantity)' do
    context 'When stock is avaliable' do
      xit 'decreases stock by quantity'
      xit 'returns true'
    end
    context 'When stock is less than quantity' do
      xit 'doesnt change stock value'
      xit 'returns false'
    end

  describe '#restock(quantity)'
    xit 'increases stock by quantity'
    xit 'returns true'
  end
end