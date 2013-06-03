require 'rspec/expectations'

module MongomadMatchersHelpers

  private
  #THING & PRODUCT
  def eq_vendable?(actual,expected)
    ['name','description','image_url','image_fingerprint'].concat(yield).each do |field|
      return false unless
      actual.send(field) == expected.send(field)
    end
    true
  end

  def eq_thing?(actual,expected)
    eq_vendable?(actual,expected) { ['stock'] }
  end

  def eq_product?(actual,expected)
    eq_vendable?(actual,expected) { ['thing_id','quantity'] }
  end


  #REQUEST
  def eq_request?(actual,expected)
    (actual.user.id == expected.user.id ) &&
      (actual.nick == expected.nick ) &&
      (actual.text == expected.text) &&
      (actual.image_url == expected.image_url) &&
      (actual.image_fingerprint == expected.image_fingerprint)
  end


  #COMPOSER, RECEIVER & MONEY
  def eq_personal_data?(actual,expected)
    (actual.nick == expected.nick) &&
      (actual.image_url == expected.image_url) &&
      (actual.image_fingerprint == expected.image_fingerprint)
  end

  def eq_side?(actual,expected)
    eq_personal_data?(actual,expected) &&
      equivalent?(actual.products,expected.products)
  end

  def eq_money?(actual,expected)
    (actual.user_id == expected.user_id) &&
      (actual.quantity == expected.quantity)
  end


  #OFFER & PROPOSAL
  def eq_offerable_participants?(actual,expected)
    (actual.user_composer_id == expected.user_composer_id) &&
      (actual.user_receiver_id == expected.user_receiver_id)
  end

  def eq_offerable?(actual,expected)
    eq_offerable_participants?(actual,expected) &&
    eq_side?(actual.composer,expected.composer) &&
    eq_side?(actual.receiver,expected.receiver) &&
    eq_money?(actual.money,expected.money)
  end

  def eq_offer?(actual,expected)
    (actual.initial_message == expected.initial_message) &&
      eq_offerable?(actual,expected)
  end

  def eq_proposal?(actual,expected)
    eq_offerable?(actual,expected)
  end


  #MESSAGE & CONVERSATION
  def eq_message?(actual,expected)
    (actual.user_id == expected.user_id) &&
      (actual.nick == expected.nick) &&
      (actual.text == expected.text) &&
      (actual.image_url == expected.image_url) &&
      (actual.image_fingerprint == expected.image_fingerprint)
  end

  def eq_conversation?(actual,expected)
    equivalent?(actual.messages,expected.messages)
  end


  #NEGOTIATION & AGREEMENT
  def eq_negotiable_participants?(actual,expected)
    if eq_klass?(actual,'Negotiation')
      if eq_klass?(expected,'Negotiation')
        (actual.negotiators.first.id == expected.negotiators.first.id) &&
          (actual.negotiators.last.id == expected.negotiators.last.id)
      else
        (actual.negotiators.first.id == expected.signers.first.id) &&
          (actual.negotiators.last.id == expected.signers.last.id)
      end
    else
      if eq_klass?(expected,'Negotiation')
        (actual.signers.first.id == expected.negotiators.first.id) &&
          (actual.signers.last.id == expected.negotiators.last.id)
      else
        (actual.signers.first.id == expected.signers.first.id) &&
          (actual.signers.last.id == expected.signers.last.id)
      end
    end
  end

  def eq_negotiable?(actual,expected)
    eq_negotiable_participants?(actual,expected) &&
    eq_conversation?(actual.conversation,expected.conversation) &&
      equivalent?(actual.proposals,expected.proposals)
  end

  def eq_negotiation?(actual,expected)
    eq_negotiable?(actual,expected)
  end

  def eq_agreement?(actual,expected)
    eq_negotiable?(actual,expected)
  end


  #DEAL
  def eq_deal?(actual,expected)
    eq_agreement?(actual.agreement,expected.agreement) &&
      eq_conversation?(actual.conversation,expected.conversation)
  end


  #COMPARATOR ENGINE
  def eq_klass?(instance,class_name)
    instance.class.name.demodulize.include?(class_name)
  end

  def are_vendables?(actual,expected)
    (eq_klass?(actual,'Product') || eq_klass?(actual,'Thing')) &&
      (eq_klass?(expected,'Product') || eq_klass?(expected,'Thing'))
  end

  def are_things?(actual,expected)
    eq_klass?(actual,'Thing') && eq_klass?(expected,'Thing')
  end

  def are_products?(actual,expected)
    eq_klass?(actual,'Product') && eq_klass?(expected,'Product')
  end

  def are_requests?(actual,expected)
    eq_klass?(actual,'Request') && eq_klass?(expected,'Request')
  end

  def are_moneys?(actual,expected)
    eq_klass?(actual,'Money') && eq_klass?(expected,'Money')
  end

  def are_offerables?(actual,expected)
    (eq_klass?(actual,'Offer') || eq_klass?(actual,'Proposal')) &&
      (eq_klass?(expected,'Offer') || eq_klass?(expected,'Proposal'))
  end

  def are_offers?(actual,expected)
    eq_klass?(actual,'Offer') && eq_klass?(expected,'Offer')
  end

  def are_proposals?(actual,expected)
    eq_klass?(actual,'Proposal') && eq_klass?(expected,'Proposal')
  end

  def are_messages?(actual,expected)
    eq_klass?(actual,'Message') && eq_klass?(expected,'Message')
  end

  def are_conversations?(actual,expected)
    eq_klass?(actual,'Conversation') && eq_klass?(expected,'Conversation')
  end

  def are_negotiables?(actual,expected)
    (eq_klass?(actual,'Negotiation') || eq_klass?(actual,'Agreement')) &&
      (eq_klass?(expected,'Negotiation') || eq_klass?(expected,'Agreement'))
  end

  def are_negotiations?(actual,expected)
    eq_klass?(actual,'Negotiation') && eq_klass?(expected,'Negotiation')
  end

  def are_agreements?(actual,expected)
    eq_klass?(actual,'Agreement') && eq_klass?(expected,'Agreement')
  end

  def are_deals?(actual,expected)
    eq_klass?(actual,'Deal') && eq_klass?(expected,'Deal')
  end

  def eq_array?(actual,expected)
    return false unless actual.size == expected.size

    actual.each_index do |index|
      return false unless
      yield(actual[index],expected[index])
    end
    true
  end

  def similar?(actual,expected)
    return eq_thing?(actual,expected)        if are_things?(actual,expected)
    return eq_product?(actual,expected)      if are_products?(actual,expected)
    return eq_vendable?(actual,expected)     if are_vendables?(actual,expected)

    return eq_request?(actual,expected)      if are_requests?(actual,expected)

    return eq_money?(actual,expected)        if are_moneys?(actual,expected)

    return eq_offer?(actual,expected)        if are_offers?(actual,expected)
    return eq_proposal?(actual,expected)     if are_proposals?(actual,expected)
    return eq_offerable?(actual,expected)    if are_offerables?(actual,expected)

    return eq_message?(actual,expected)      if are_messages?(actual,expected)
    return eq_conversation?(actual,expected) if are_conversations?(actual,expected)

    return eq_negotiation?(actual,expected)  if are_negotiations?(actual,expected)
    return eq_agreement?(actual,expected)    if are_agreements?(actual,expected)
    return eq_negotiable?(actual,expected)   if are_negotiables?(actual,expected)

    return eq_deal?(actual,expected)         if are_deals?(actual,expected)
    false
  end

  public
  def equivalent?(actual,expected)
    if eq_klass?(actual,'Array') && eq_klass?(expected,'Array')
      eq_array?(actual,expected) do |actual_element,expected_element|
        similar?(actual_element,expected_element)
      end
    else
      similar?(actual,expected)
    end
  end
end

module MongomadMatchers
  extend RSpec::Matchers::DSL
  include MongomadMatchersHelpers

  matcher :be_like do |expected|
    match { |actual| equivalent?(actual,expected) }
    # TO-DO Mensaje para las diferencias
    diffable
  end
end
