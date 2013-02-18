require 'rspec/expectations'

module MongomadMatchersHelpers

  def same_participants?(actual,expected)
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
    same_participants?(actual,expected) &&

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

  def same_messages?(actual,expected)
    actual.messages.each_index do |index|
      return false unless
      actual.messages[index].user_name = expected.messages[index].user_name &&
      actual.messages[index].text = expected.messages[index].text &&
      actual.messages[index].image_name = expected..messages[index].image_name
    end
  end
end

module MongomadMatchers
  extend RSpec::Matchers::DSL
  include MongomadMatchersHelpers

  matcher :match_participants_with do |expected|
    match { |actual| same_participants?(actual,expected) }
    diffable
  end

  matcher :match_products_with do |expected|
    match do |actual|
      %w(composer receiver).each do |participant|
        return false unless
          same_products?(actual.send(participant).products,expected.send(participant).products)
      end
    end
    diffable
  end

  matcher :match_money_with do |expected|
    match { |actual| same_money?(actual,expected) }
    diffable
  end

  matcher :match_stuff_with do |expected|
    match { |actual| same_contents?(actual,expected) }
    # TO-DO Mensaje para las diferencias
    diffable
  end

  matcher :match_messages_with do |expected|
    match { |actual| same_messages?(actual,expected)}
    diffable
  end
end

