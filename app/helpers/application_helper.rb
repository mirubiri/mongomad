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
    if object.class == Offer
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
    object._id
  end

  # def image_service_path(object)
  #   cl_image_path(object._id + ".jpg")
  # end

  # def image_service_tag(object)
  #   cl_image_tag(object._id + ".jpg")
  # end

  def images(object)
    user_sheet(object).images
  end

  def items(object)
    User.find(object._id).items
  end

  def language(object)
    object.profile.language
  end

  def last_name(object)
    user_sheet(object).last_name
  end

  def main_image(object)
    user_sheet(object).main_image
  end

  def message(object)
    if object.class == Offer
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

  def proposals(object)
    object.proposals
  end

  def received_offers(object)
    object.received_offers
  end

  def receiver(object)
    object.receiver
  end

  def receiver_products(object)
    if object.class == Offer
      products(proposal(object), receiver(object))
    else
      products(object, receiver(object))
    end
  end

  def requests(object)
    object.requests
  end

  def sent_offers(object)
    object.sent_offers
  end

  def state(object)
    object.state
  end

  def text(object)
    object.text
  end

  def user(object)
    object.user
  end

  def user_sheet(object)
    if object.class == User
      object.sheet
    elsif object.class == Request
      object.user_sheet
    elsif object.class == Message
      object.user_sheet
    else
      object
    end
  end

  # Static images
  def header_image
    cl_image_tag("static/images/header.jpg", :width => 240, :height => 160, :crop => :scale)
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

  def star_icon_image
    cl_image_tag("static/icons/star.png", :width => 25, :height => 23, :crop => :scale)
  end

  def friends_icon_image
    cl_image_tag("static/icons/friends_black.png", :width => 34, :height => 20, :crop => :scale)
  end

  def sound_icon_image
    cl_image_tag("static/icons/sound.png", :width => 11, :height => 14, :crop => :scale)
  end

  def video_icon_image
    cl_image_tag("static/icons/video.png", :width => 20, :height => 10, :crop => :scale)
  end

  def initial_message_icon_image
    cl_image_tag("static/icons/initial_message.png", :width => 29, :height => 27, :crop => :scale)
  end

  def friends_menu_icon_image
    cl_image_tag("static/icons/friends_white.png", :width => 26, :height => 26, :crop => :scale)
  end

  def products_menu_icon_image
    cl_image_tag("static/icons/products.png", :width => 26, :height => 26, :crop => :scale)
  end

  def negotiations_menu_icon_image
    cl_image_tag("static/icons/negotiations.png", :width => 26, :height => 26, :crop => :scale)
  end

  def deals_menu_icon_image
    cl_image_tag("static/icons/deals.png", :width => 26, :height => 26, :crop => :scale)
  end

  def logout_menu_icon_image
    cl_image_tag("static/icons/logout.png", :width => 19, :height => 21, :crop => :scale)
  end

  #Dynamic images
  def header_user_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 68, :height => 68, :crop => :scale, :radius => :max)
  end

  def user_logged_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 30, :height => 30, :crop => :scale, :radius => :max)
  end

  def profile_user_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 122, :height => 122, :crop => :scale)
  end

  def message_user_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 30, :height => 30, :crop => :scale)
  end

  def request_user_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 39, :height => 39, :crop => :scale)
  end

  def offer_user_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 48, :height => 48, :crop => :scale, :radius => :max)
  end

  def negotiation_user_face_image(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 64, :height => 64, :crop => :scale, :radius => :max)
  end

  def item_image_big(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 152, :height => 152, :crop => :scale)
  end

  def item_image_small(object)
    cl_image_tag((user_sheet(object).main_image)._id + ".jpg", :width => 60, :height => 60, :crop => :scale)
  end

  #TODO: Revisar
  def cu_image_service_path(object)
    cl_image_path(object._id + ".jpg", :width => 60, :height => 60, :crop => :fill)
  end
end
