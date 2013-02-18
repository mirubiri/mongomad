require 'rspec/expectations'

module MongomadMatchersHelpers

  def same_users?(actual,expected)
    expected.user_composer_id == actual.user_composer_id &&
    expected.user_receiver_id == actual.user_receiver_id
  end

  def same_participant_data?(actual,expected)
    expected.name == actual.name &&
    expected.image_name == actual.image_name
  end

  def same_products?(actual,expected)
    expected.products.each_index do |index|
      %w(name description thing_id image_name quantity).each do |field|
        return false unless
          actual.products[index].send(field) == expected.products[index].send(field)
      end
    end
  end

  def same_money?(actual,expected)
    expected.user_id == actual.user_id &&
    expected.quantity == actual.quantity
  end

  def same_offer?(actual,expected)
    actual.initial_message == expected.initial_message &&
    same_proposal?(actual,expected)
  end


  def same_proposal?(actual,expected)
    same_money?(actual.money,expected.money) &&
    same_users?(actual,expected) &&

    %w(composer receiver).each do |participant|
      return false unless
        same_participant_data?(actual.send(participant),expected.send(participant)) &&
        same_products?(actual.send(participant),expected.send(participant))
    end
  end

  def same_contents?(actual,expected)
    if actual.respond_to?(:initial_message) && expected.respond_to?(:initial_message)
      same_offer?(actual,expected)
    else
      same_proposal?(actual,expected)
    end
  end
end

module MongomadMatchers
  extend RSpec::Matchers::DSL
  include MongomadMatchersHelpers

  matcher :have_same_participants do |expected|
    match { |actual| same_participants?(actual,expected) }
    diffable
  end

  matcher :have_same_products do |expected|
    match do |actual|
      %w(composer receiver).each do |participant|
        return false unless
          same_products?(actual.send(participant).products,expected.send(participant).products)
      end
    end
    diffable
  end

  matcher :have_same_money do |expected|
    match { |actual| same_money?(actual,expected) }
    diffable
  end

  matcher :have_same_contents_as do |expected|
    match { |actual| same_contents?(actual,expected) }
    # TO-DO Mensaje para las diferencias
    diffable
  end
end
