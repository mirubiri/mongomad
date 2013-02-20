require 'rspec/expectations'

module MongomadMatchersHelpers

protected
#THING & PRODUCT
  def eq_vendable?(actual,expected)
    ['name', 'description', 'image_name',].concat(yield).each do |field|
      return false unless
        actual.send(field) == expected.send(field)
    end
  end

  def eq_thing?(actual,expected)
    eq_vendable?(actual,expected) { ['stock'] }
  end

  def eq_product?(actual,expected)
    eq_vendable?(actual,expected) { ['quantity','thing_id'] }
  end


#MONEY
  def eq_money?(actual,expected)
    expected.user_id == actual.user_id &&
    expected.quantity == actual.quantity
  end


#MESSAGE
  def eq_message?(actual,expected)
    actual.user_name = expected.user_name &&
    actual.text = expected.text &&
    actual.image_name = expected.image_name
  end

#COMPOSER & RECEIVER
  ## No vale para negociaciones y deals

  def eq_personal_data?(actual,expected)
    expected.name == actual.name &&
    expected.image_name == actual.image_name
  end

  def eq_side?(actual,expected)
    eq_personal_data?(actual,expected) &&
    equivalent?(actual.products,expected.products)
  end

#OFFER & PROPOSAL
  
  def eq_offerable_participants?(actual,expected)
    expected.user_composer_id == actual.user_composer_id &&
    expected.user_receiver_id == actual.user_receiver_id
  end
  
  def eq_offerable?(actual,expected)
    eq_offerable_participants?(actual,expected) &&
    eq_money?(actual.money,expected.money) &&

    eq_side?(actual.composer,expected.composer) &&
    eq_side?(actual.receiver,expected.receiver)
  end


  def eq_proposal?(actual,expected)
    eq_offerable?(actual,expected)
  end

  def eq_offer?(actual,expected)
    actual.initial_message == expected.initial_message &&
    eq_offerable?(actual,expected)
  end



#REQUEST

  def eq_request?(actual,expected)
    actual.user_name == expected.user_name &&
    actual.text == expected.text &&
    actual.image == expected.image
  end

=begin
#AGREEMENT

# def eq_agreement(actual,expected)

#DEAL & NEGOTIATION

def eq_negotiation_participants(actual,expected)
  actual.negotiator_ids == expected.negotiator_ids
end

def eq_negotiation(actual,expected)
  eq_negotiation_participants(actual,expected) &&
  equivalent?(actual.proposals,expected.proposals) &&
  equivalent?(actual.messages,expected.messages)
end

#def eq_deal(actual,expected)
=end

#COMPARATOR ENGINE

#CHECKERS
  def eq_klass?(instance,class_name)
    instance.class.name.demodulize.include?(class_name)
  end

  def are_offers?(actual,expected)
    eq_klass?(actual,'Offer') && eq_klass?(expected,'Offer')
  end

  def are_proposals?(actual,expected)
    eq_klass?(actual,'Proposal') && eq_klass?(expected,'Proposal')
  end

  def are_offerables?(actual,expected)
    eq_klass?(actual,'Offer') || eq_klass?(actual,'Proposal') &&
    eq_klass?(expected,'Offer') || eq_klass?(expected,'Proposal')
  end

  def are_products?(actual,expected)
    eq_klass?(actual,'Product') && eq_klass?(expected,'Product')
  end

  def are_things?(actual,expected)
    eq_klass?(actual,'Thing') && eq_klass?(expected,'Thing')
  end

  def are_vendables?(actual,expected)
    eq_klass?(actual,'Product') || eq_klass?(actual,'Thing') &&
    eq_klass?(expected,'Product') || eq_klass?(expected,'Thing')
  end
  
  def are_requests?(actual,expected)
    eq_klass?(actual,'Request') && eq_klass?(expected,'Request')
  end



  def eq_array?(actual,expected)
    return false unless actual.size == expected.size
    
    actual.each_index do |index|
      return false unless
        yield(actual[index],expected[index])
    end
  end

  def similar?(actual,expected)
    # El orden es importante, no se puede cambiar

    return eq_offer?(actual,expected)     if are_offers?(actual,expected)
    return eq_proposal?(actual,expected)  if are_proposals?(actual,expected)
    return eq_offerable?(actual,expected) if are_offerables?(actual,expected)
    
    return eq_thing?(actual,expected)    if are_things?(actual,expected)
    return eq_product?(actual,expected)  if are_products?(actual,expected)
    return eq_vendable?(actual,expected) if are_vendables?(actual,expected)

    return eq_message?(actual,expected)  if are_messages?(actual,expected)
    return eq_request?(actual,expected)  if are_requests?(actual,expected)

    #return eq_negotiation?(actual,expected)  if are_negotiations?(actual,expected)
    #return eq_deal?(actual,expected)         if are_deals?(actual,expected)
    #return eq_agreement?(actual,expected)    if are_deals?(actual,expected)
    #return eq_business?(actual,expected)     if are_business?(actual,expected)
    false
  end

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

