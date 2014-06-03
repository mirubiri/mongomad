require 'rails_helper'

describe Product, :type => :model do
  # Modules
  it { is_expected.to include_module AutoUpdate }
  it { is_expected.to include_module Attachment::Images }

  # Relations
  specify { expect(Product).to be < Good }

  # Attributes
  it { is_expected.to have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { is_expected.to have_fields :name, :description }
  it { is_expected.to auto_update(:name, :description, :images).using :item }

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
