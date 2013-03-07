module ApplicationHelper

  # USER (USER_LOGGED) HELPERS -----------------------------------------
  def user_logged_id(user = user_logged)
    user._id
  end
  def user_logged_name(user = user_logged)
    user.profile.name
  end
  def user_logged_surname(user = user_logged)
    user.profile.surname
  end
  def user_logged_nickname(user = user_logged)
    user.profile.nickname
  end
  def user_logged_sex(user = user_logged)
    user.profile.sex
  end
  def user_logged_country(user = user_logged)
    user.profile.country
  end
  def user_logged_delivery_adress(user = user_logged)
    user.profile.delivery_adress
  end
  def user_logged_phone_number(user = user_logged)
    user.profile.phone_number
  end
  def user_logged_website(user = user_logged)
    user.profile.website
  end
  def user_logged_bithdate(user = user_logged)
    user.profile.bithdate
  end
  def user_logged_image(user = user_logged)
    image_tag(user.profile.image)
  end
  def user_logged_datetime(user = user_logged)
    user.profile.created_at
  end
  def user_logged_updatetime(user = user_logged)
    user.profile.updated_at
  end
  def user_logged_things(user = user_logged)
    user.things
  end
  def user_logged_requests(user = user_logged)
    user.requests
  end
  def user_logged_sent_offers(user = user_logged)
    user.sent_offers
  end
  #TODO: Cambiar nombre a 'user_logged_received_offers'
  #def user_logged_received_offers(user = user_logged)
  def user_logged_offers(user = user_logged) 
    user.received_offers
  end
  def user_logged_negotiations(user = user_logged)
    user.negotiations
  end
  def user_logged_deals(user = user_logged)
    user.deals
  end

  # USER (USER_VISITED) HELPERS -----------------------------------------
  def user_visited_id
    @user._id
  end
  def user_visited_name
    @user.profile.name
  end
  def user_visited_surname
    @user.profile.surname
  end
  def user_visited_nickname
    @user.profile.nickname
  end
  def user_visited_sex
    @user.profile.sex
  end
  def user_visited_country
    @user.profile.country
  end
  def user_visited_delivery_adress
    @user.profile.delivery_adress
  end
  def user_visited_phone_number
    @user.profile.phone_number
  end
  def user_visited_website
    @user.profile.website
  end
  def user_visited_birthdate
    @user.profile.birth_date
  end
  def user_visited_image
    image_tag(@user.profile.image)
  end
  def user_visited_datetime
    @user.profile.created_at
  end
  def user_visited_updatetime
    @user.profile.updated_at
  end
  def user_visited_things
    @user.things
  end
  def user_visited_requests
    @user.requests
  end
  def user_visited_sent_offers
    @user.sent_offers
  end
  #TODO: Cambiar nombre a 'user_visited_received_offers'
  #def user_visited_received_offers
  def user_visited_offers 
    @user.received_offers
  end
  def user_visited_negotiations
    @user.negotiations
  end
  def user_visited_deals
    @user.deals
  end
  def user_requests
    @user.requests
  end

  # THING HELPERS -----------------------------------------
  def thing_id(thing)
    thing._id
  end
  def thing_name(thing)
    thing.name
  end
  def thing_description(thing)
    thing.description
  end
  def thing_stock(thing)
    thing.stock
  end
  def thing_image(thing)
    image_tag(thing.image)
  end
  def thing_inboard(thing)
    image_tag(thing.image, :alt => '200x100', :width => '200', :height => '100')
  end

  # REQUEST HELPERS -----------------------------------------
  def request_id(request)
    request._id
  end
  def request_user_id(request)
    request.user_id
  end
  def request_user_name(request)
    request.user_name
  end
  def request_text(request)
    request.text
  end
  def request_image(request)
    image_tag(request.image)
  end
  def request_datetime(request)
    request.created_at
  end
  def request_updatetime(request)
    request.updated_at
  end

  # OFFER HELPERS -----------------------------------------
  def offer_id(offer)
    offer._id
  end
  def offer_composer_id(offer)
    offer.user_composer_id
  end
  def offer_composer_name(offer)
    offer.composer.name
  end
  def offer_composer_image(offer)
    image_tag(offer.composer.image)
  end
  def offer_composer_products(offer)
    offer.composer.products
  end
  def offer_receiver_id(offer)
    offer.user_receiver_id
  end
  def offer_receiver_name(offer)
    offer.receiver.name
  end
  def offer_receiver_image(offer)
    image_tag(offer.receiver.image)
  end
  def offer_receiver_products(offer)
    offer.receiver.products
  end
  def offer_money_owner_id(offer)
    offer.money.user_id
  end
  def offer_money_quantity(offer)
    offer.money.quantity
  end
  def offer_message(offer)
    offer.initial_message
  end
  def offer_datetime(offer)
    offer.created_at
  end
  def offer_updatetime(offer)
    offer.updated_at
  end

  # PRODUCT HELPERS -----------------------------------------
  def product_id(product)
    product._id
  end
  def product_thing_id(product)
    product.thing_id
  end
  def product_name(product)
    product.name
  end
  def product_description(product)
    product.description
  end
  def product_quantity(product)
    product.quantity
  end
  def product_image(product)
    image_tag(product.image)
  end

  # NEGOTIATION HELPERS -----------------------------------------
  def negotiation_id(negotiation)
    negotiation._id
  end
  def negotiation_proposals(negotiation)
    negotiation.proposals
  end
  def negotiation_messages(negotiation)
    negotiation.messages
  end
  def negotiation_users(negotiation)
    negotiation.users
  end
  def negotiation_composer_name(negotiation)
    negotiation.proposals.last.composer.name
  end
  def negotiation_composer_image(negotiation)
    image_tag(negotiation.proposals.last.composer.image)
  end
  def negotiation_composer_products(negotiation)
    negotiation.proposals.last.composer.products
  end
  def negotiation_composer_id(negotiation)
    negotiation.proposals.last.user_composer_id
  end
  def negotiation_receiver_image(negotiation)
    image_tag(negotiation.proposals.last.receiver.image)
  end
  def negotiation_receiver_products(negotiation)
    negotiation.proposals.last.receiver.products
  end
  def negotiation_datetime(negotiation)
    negotiation.created_at
  end
  def negotiation_updatetime(negotiation)
    negotiation.updated_at
  end

  # PROPOSAL HELPERS -----------------------------------------
  def proposal_id(proposal)
    proposal._id
  end
  def proposal_composer_id(proposal)
    proposal.user_composer_id
  end
  def proposal_composer_name(proposal)
     proposal.composer.name
  end
  def proposal_composer_image(proposal)
    image_tag(proposal.composer.image)
  end
  def proposal_composer_products(proposal)
    proposal.composer.products
  end
  def proposal_receiver_id(proposal)
    proposal.user_receiver_id
  end
  def proposal_receiver_name(proposal)
    proposal.receiver.name
  end
  def proposal_receiver_image(proposal)
    image_tag(proposal.receiver.image)
  end
  def proposal_receiver_products(proposal)
    proposal.receiver.products
  end
  def proposal_money_owner_id(proposal)
    proposal.money.user_id
  end
  def proposal_money_quantity(proposal)
    proposal.money.quantity
  end
  def proposal_datetime(proposal)
    proposal.created_at
  end
  def proposal_updatetime(proposal)
    proposal.updated_at
  end

  # MESSAGE HELPERS -----------------------------------------
  def message_id(message)
    message._id
  end
  def message_user_name(message)
    message.user_name
  end
  def message_text(message)
    message.text
  end
  def message_image(message)
    message.image
  end
  def message_datetime(message)
    message.created_at
  end
  def message_updatetime(message)
    message.updated_at
  end

  # DEAL HELPERS -----------------------------------------
  def deal_id(deal)
    deal._id
  end
  def deal_agreemen(deal)
    deal.proposals
  end
  def deal_messages(deal)
    deal.messages
  end
  def deal_users(deal)
    deal.users
  end
  def deal_composer_image(deal)
    image_tag(deal.agreement.proposals.last.composer.image)
  end
  def deal_composer_products(deal)
    deal.agreement.proposals.last.composer.products
  end
  def deal_receiver_image(deal)
    image_tag(deal.agreement.proposals.last.receiver.image)
  end
  def deal_receiver_products(deal)
    deal.agreement.proposals.last.receiver.products
  end
  def deal_datetime(deal)
    deal.created_at
  end
  def deal_updatetime(deal)
    deal.updated_at
  end

  # AGREEMENT HELPERS -----------------------------------------
  def agreement_id(agreement)
    agreement._id
  end
  def agreement_proposals(agreement)
    agreement.proposals
  end
  def agreement_messages(agreement)
    agreement.messages
  end
  def agreement_datetime(agreement)
    agreement.created_at
  end
  def agreement_updatetime(agreement)
    agreement.updated_at
  end
end
