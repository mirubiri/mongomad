require 'spec_helper'

describe Product do
  # Modules
  it { should include_module AutoUpdate }
  it { should include_module Attachment::Images }

  # Relations
  specify { Product.should < Good }

  # Attributes
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { should have_fields :name, :description }
  it { should auto_update(:name, :description, :images).using :item }

  # Validations

  # Methods
  specify '.new' do
    expect(Product.new.id).to eq nil
  end

  describe '#withdraw' do
  end

  describe '#sell' do
  end

  # Factories
end
