module ApplicationHelper
  def alerts(object)
    object.alerts
  end

  def agreement(object)
    object.agreement
  end

  def birth_date(object)
    object.profile.birth_date
  end

  def composer(object)
    object.composer
  end

  def composer_products(object)
    case object.class
    when Offer
      products(proposal(object), composer(object))
    else
      products(object, composer(object))
    end
  end

  def date_time(object)
    object.updated_at
  end

  def deals(object)
    object.deals
  end

  def description(object)
    object.description
  end

  def first_name(object)
    user_sheet(object).first_name
  end

  def full_name(object)
    first_name(object) + " " + last_name(object)
  end

  def gender(object)
    object.profile.gender
  end

  def id(object)
    object.id
  end

  def images(object)
    user_sheet(object).images.desc(:updated_at)
  end

  def items(object)
    object.items.desc(:updated_at)
  end

  def language(object)
    object.profile.language
  end

  def location(object)
    user_sheet(object).nick
  end

  def last_name(object)
    user_sheet(object).last_name
  end

  def main_image(object)
    user_sheet(object).main_image
  end

  def message(object)
    case object.class
    when Offer
      object.message
    else
      messages(object).last
    end
  end

  def messages(object)
    object.messages
  end

  def name(object)
    object.name
  end

  def negotiations(object)
    object.negotiations
  end

  def nick(object)
    user_sheet(object).nick
  end

  def products(object, user)
    object.products(user.id)
  end

  def proposal(object)
    object.proposal
  end

  def received_offers(object)
    object.received_offers
  end

  def receiver(object)
    object.receiver
  end

  def receiver_products(object)
    case object.class
    when Offer
      products(proposal(object), receiver(object))
    else
      products(object, receiver(object))
    end
  end

  def requests(object)
    object.requests.desc(:updated_at)
  end

  def text(object)
    object.text
  end

  def user_sheet(object)
    case object.class
    when User
      object.sheet
    when Request, Message
      object.user_sheet
    else
      object
    end
  end

  # Static images
  def friends_menu_icon
    cl_image_tag("static/icons/friends_white.png", :width => 26, :height => 26, :crop => :fit)
  end

  def products_menu_icon
    cl_image_tag("static/icons/products.png", :width => 26, :height => 26, :crop => :fit)
  end

  def negotiations_menu_icon
    cl_image_tag("static/icons/negotiations.png", :width => 26, :height => 26, :crop => :fit)
  end

  def deals_menu_icon
    cl_image_tag("static/icons/deals.png", :width => 26, :height => 26, :crop => :fit)
  end

  def logout_menu_icon
    cl_image_tag("static/icons/logout.png", :width => 19, :height => 21, :crop => :fit)
  end

  def header_image
    cl_image_tag("static/images/header.jpg", :width => 240, :height => 160, :crop => :fit)
  end

  def star_icon
    cl_image_tag("static/icons/star.png", :width => 25, :height => 23, :crop => :fit)
  end

  def friends_icon
    cl_image_tag("static/icons/friends_black.png", :width => 34, :height => 20, :crop => :fit)
  end

  def no_requests_image
    cl_image_tag("static/images/no_requests.png", :width => 218, :height => 200, :crop => :fit)
  end

  def no_offers_image
    cl_image_tag("static/images/no_offers.png", :width => 269, :height => 358, :crop => :fit)
  end

  def add_item_image
    cl_image_tag("static/images/add_item.png", :width => 152, :height => 152, :crop => :fit)
  end

  #TODO: Tamaño diferente al original (29x27)
  def initial_message_icon
    cl_image_tag("static/icons/initial_message.png", :width => 50, :height => 50, :crop => :fit)
  end

  #TODO: Tamaño diferente al original (148x105)
  def money_image
    cl_image_tag("static/images/money.png", :width => 165, :height => 165, :crop => :fit)
  end

  def sound_icon
    cl_image_tag("static/icons/sound.png", :width => 11, :height => 14, :crop => :fit)
  end

  def video_icon
    cl_image_tag("static/icons/video.png", :width => 20, :height => 10, :crop => :fit)
  end

  # Dynamic images
  def logged_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :fit, :radius => :max)
  end

  def header_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 68, :height => 68, :crop => :fit, :radius => :max)
  end

  def profile_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 122, :height => 122, :crop => :fit)
  end

  def comment_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :fit)
  end

  def request_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 39, :height => 39, :crop => :fit)
  end

  def request_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :fit, :radius => :max)
  end

  def offer_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :fit, :radius => :max)
  end

  def offer_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def offer_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :fit)
  end

  def offer_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :fit, :radius => :max)
  end

  def offer_modal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :fit)
  end

  def offer_modal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :fit)
  end

  def negotiation_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 64, :height => 64, :crop => :fit, :radius => :max)
  end

  def negotiation_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def negotiation_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :fit)
  end

  def negotiation_message_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :fit)
  end

  def negotiation_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :fit, :radius => :max)
  end

  def negotiation_modal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :fit)
  end

  def negotiation_modal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :fit)
  end

  def deal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 64, :height => 64, :crop => :fit, :radius => :max)
  end

  def deal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def deal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :fit)
  end

  def deal_message_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :fit)
  end

#   def alert_user_image(object)
#     cl_image_tag(id(main_image(object)) + ".jpg", :width => 39, :height => 39, :crop => :fit)
#   end

  def products_wall_item_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :fit)
  end

  def product_modal_item_main_image(object)
    if images(object).size > 0
      cl_image_tag(id(main_image(object)) + ".jpg", :width => 270, :height => 270, :crop => :fit)
    else
      '<img src=''>'.html_safe
    end
  end

  def product_modal_item_first_image(object)
    if images(object).size > 0
      cl_image_tag(id(images(object)[0]) + ".jpg", :width => 270, :height => 270, :crop => :fit)
    else
      '<img src=''>'.html_safe
    end
  end

  def product_modal_item_second_image(object)
    if images(object).size > 1
      cl_image_tag(id(images(object)[1]) + ".jpg", :width => 270, :height => 270, :crop => :fit)
    else
      '<img src=''>'.html_safe
    end
  end

  def product_modal_item_third_image(object)
    if images(object).size > 2
      cl_image_tag(id(images(object)[2]) + ".jpg", :width => 270, :height => 270, :crop => :fit)
    else
      '<img src=''>'.html_safe
    end
  end

  # TODO: ELIMINAR, solo para debug
  def debug_info(object)
    case object.class
    when Item
      item_info(object)
    when Product
      "PRODUCT: state: #{object.state} " + item_info(object.item)
    when Offer
      "OFFER: state: #{object.state}, discarded: #{object.discarded}, negotiating: #{object.negotiating}, negotiated_times: #{object.negotiated_times} " + proposal_info(proposal(object))
    when Negotiation
      "NEGOTIATION: absent_user: #{object.absent_user}, discarded: #{object.discarded} " + proposal_info(proposal(object))
    when Deal
      proposal_info(agreement(object))
    else
      "Debug Info"
    end
  end

  def item_info(item)
    "ITEM: state: #{item.state}, discarded: #{item.discarded}"
  end

  def proposal_info(proposal)
    "PROPOSAL: state: #{proposal.state}, actionable: #{proposal.actionable}"
  end
end
