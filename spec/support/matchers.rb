require 'rspec/expectations'

module MongomadMatchersHelpers

# THINGS & PRODUCTS
  def same_things?(actual,expected)
    expected.products.each_index do |index|
      ['name', 'description', 'thing_id', 'image_name', yield || 'quantity'].each do |field|
        return false unless
          actual.products[index].send(field) == expected.products[index].send(field)
      end
    end
  end

  def same_vendables?(actual,expected)
    same_things?(actual,expected) { 'stock' }
  end

# MONEY
  def same_moneys?(actual,expected)
    expected.user_id == actual.user_id &&
    expected.quantity == actual.quantity
  end

# MESSAGES
  def same_messages?(actual,expected)
    return false unless
      actual.user_name = expected.user_name &&
      actual.text = expected.text &&
      actual.image_name = expected.image_name
  end

# OFFERS & PROPOSALS
  def same_participants?(actual,expected)
    expected.user_composer_id == actual.user_composer_id &&
    expected.user_receiver_id == actual.user_receiver_id
  end

  def same_participant_datas?(actual,expected)
    expected.name == actual.name &&
    expected.image_name == actual.image_name
  end

  def same_proposals?(actual,expected)
    same_moneys?(actual.money,expected.money) &&
    same_participants?(actual,expected) &&

    %w(composer receiver).each do |participant|
      return false unless
        same_participant_datas?(actual.send(participant),expected.send(participant)) &&
        same_products?(actual.send(participant),expected.send(participant))
    end
  end

  def same_offers?(actual,expected)
    actual.initial_message == expected.initial_message &&
    same_proposals?(actual,expected)
  end


# CHECKERS
  def check_class(instance,class_name)
    instance.class.name.demodulize.include?(class_name)
  end

  def are_offers?(actual,expected)
    check_class(actual,'Offer') && check_class(expected,'Offer')
  end

  def are_offerables?(actual,expected)
    check_class(actual,'Offer') || check_class(actual,'Proposal') &&
    check_class(expected,'Offer') || check_class(expected,'Proposal')
  end

  def are_things?(actual,expected)
    check_class(actual,'Thing') && check_class(expected,'Thing')
  end

  def are_vendables?(actual,expected)
    check_class(actual,'Product') || check_class(actual,'Thing') &&
    check_class(expected,'Product') || check_class(expected,'Thing')
  end

# COMPARATOR
  def same_contents?(actual,expected)
    return same_offers?(actual,expected)    if are_offers?(actual,expected)
    return same_proposals?(actual,expected) if are_offerables?(actual,expected)

    return same_things(actual,expected)     if are_things?(actual,expected)
    return same_vendables?(actual,expected) if are_vendables?(actual,expected)

    return same_requests?(actual,expected)  if are_requests?(actual,expected)
    return same_messages?(actual,expected)  if are_messages?(actual,expected)
    false
    # TO-DO LA COMPARACION DE THINGS Y PRODUCTS TODAVIA NO FUNCIONA
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
    match { |actual| same_moneys?(actual,expected) }
    diffable
  end

  matcher :match_stuff_with do |expected|
    match { |actual| same_contents?(actual,expected) }
    # TO-DO Mensaje para las diferencias
    diffable
  end

  matcher :match_messages_with do |expected|
    match { |actual| same_messages?(actual,expected) }
    diffable
  end
end

