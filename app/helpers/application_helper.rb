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
    object.created_at
  end

  def deals(object)
    object.deals
  end

#   def description(object)
#     object.description
#   end

  def first_name(object)
    user_sheet(object).first_name
  end

  def full_name(object)
    first_name(object) + " " + last_name(object)
  end

#   def gender(object)
#     object.profile.gender
#   end

  def id(object)
    object._id
  end

#   def images(object)
#     user_sheet(object).images
#   end

  def items(object)
    User.find(object._id).items
  end

#   def language(object)
#     object.profile.language
#   end

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
    object.products(user._id)
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
    object.requests
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
    cl_image_tag("static/icons/friends_white.png", :width => 26, :height => 26, :crop => :scale)
  end

  def products_menu_icon
    cl_image_tag("static/icons/products.png", :width => 26, :height => 26, :crop => :scale)
  end

  def negotiations_menu_icon
    cl_image_tag("static/icons/negotiations.png", :width => 26, :height => 26, :crop => :scale)
  end

  def deals_menu_icon
    cl_image_tag("static/icons/deals.png", :width => 26, :height => 26, :crop => :scale)
  end

  def logout_menu_icon
    cl_image_tag("static/icons/logout.png", :width => 19, :height => 21, :crop => :scale)
  end

  def header_image
    cl_image_tag("static/images/header.jpg", :width => 240, :height => 160, :crop => :scale)
  end

  def star_icon
    cl_image_tag("static/icons/star.png", :width => 25, :height => 23, :crop => :scale)
  end

  def friends_icon
    cl_image_tag("static/icons/friends_black.png", :width => 34, :height => 20, :crop => :scale)
  end

  def no_requests_image
    cl_image_tag("static/images/no_requests.png", :width => 218, :height => 200, :crop => :scale)
  end

  def no_offers_image
    cl_image_tag("static/images/no_offers.png", :width => 269, :height => 358, :crop => :scale)
  end

  def add_item_image
    cl_image_tag("static/images/add_item.png", :width => 152, :height => 152, :crop => :scale)
  end

  #TODO: Tamaño diferente al original (29x27)
  def initial_message_icon
    cl_image_tag("static/icons/initial_message.png", :width => 50, :height => 50, :crop => :scale)
  end

  #TODO: Tamaño diferente al original (148x105)
  def money_image
    cl_image_tag("static/images/money.png", :width => 165, :height => 165, :crop => :scale)
  end

  def sound_icon
    cl_image_tag("static/icons/sound.png", :width => 11, :height => 14, :crop => :scale)
  end

  def video_icon
    cl_image_tag("static/icons/video.png", :width => 20, :height => 10, :crop => :scale)
  end

  # Dynamic images
  def logged_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :scale, :radius => :max)
  end

  def header_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 68, :height => 68, :crop => :scale, :radius => :max)
  end

  def profile_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 122, :height => 122, :crop => :scale)
  end

  def comment_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :scale)
  end

  def request_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 39, :height => 39, :crop => :scale)
  end

  def request_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :scale, :radius => :max)
  end

  def offer_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :scale, :radius => :max)
  end

  def offer_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :scale)
  end

  def offer_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :scale)
  end

  def offer_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :scale, :radius => :max)
  end

  def offer_modal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :scale)
  end

  def offer_modal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :scale)
  end

  def negotiation_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 64, :height => 64, :crop => :scale, :radius => :max)
  end

  def negotiation_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :scale)
  end

  def negotiation_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :scale)
  end

  def negotiation_message_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :scale)
  end

  def negotiation_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :scale, :radius => :max)
  end

  def negotiation_modal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :scale)
  end

  def negotiation_modal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 165, :height => 165, :crop => :scale)
  end

  def deal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 64, :height => 64, :crop => :scale, :radius => :max)
  end

  def deal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :scale)
  end

  def deal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :scale)
  end

  def deal_message_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :scale)
  end

#   def alert_user_image(object)
#     cl_image_tag(id(main_image(object)) + ".jpg", :width => 39, :height => 39, :crop => :scale)
#   end

  def products_wall_item_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :scale)
  end

#   def product_modal_item_image(object)
#     cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :scale)
#   end

#   #TODO: Revisar
#   def quantity(object)
#     1
#   end
end
