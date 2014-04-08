class ItemsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user.items.size != 0 ? @items = @user.items.desc(:updated_at) : @items = nil

    respond_to do |format|
      format.html # index.html.erb
      format.js # renders index.js.erb
    end
  end

  def show
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render 'show', :layout => false, :locals => { :item => @item } }
    end
  end

  def new
    @user = User.find(params[:user_id])
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb
    end
  end

  def create
    @user = User.find(params[:user_id])
    @item = update_item(Item.new, params[:item])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @user.items << @item
        format.html { redirect_to user_items_url, notice: 'Item has been successfully created.' }
        format.js { render 'add_item_in_list', :layout => false, :locals => { :item => @item }, :status => :created }
      else
        format.html { render action: "index" }
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])
    @item = update_item(@item, params[:item])

    products = search_in_offers_products_to_outdate(@item.id).to_a.concat search_in_negotiations_products_to_outdate(@item.id).to_a
    products = outdate_products(products)

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if save_products(products) && save_item(@item)
        @items = @user.items.desc(:updated_at)
        format.html { redirect_to user_items_path(@user), notice: 'Item has been successfully updated.' }
        format.js { render 'reload_items', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])
    @item.withdraw

    products = search_in_offers_products_to_withdraw(@item.id).to_a.concat search_in_negotiations_products_to_withdraw(@item.id).to_a
    products = withdraw_products(products)

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if save_products(products) && save_item(@item)
        format.html { redirect_to user_items_url, notice: 'Item has been successfully deleted.' }
      else
        # ni idea :)
      end
    end
  end

  private
  def update_item(item, params)
    name = params[:name]
    description = params[:description]
    images = []
    params[:images].each do |image_params|
      image = Attachment::Image.new(main:image_params[:main])
      image.id = image_params[:public_id]
      images << image
    end

    item.name = name
    item.description = description
    item.images = nil
    item.images << images
    item
  end

  def search_in_offers_products_to_outdate(item_id)
    offers_array = Offer.where('proposal.goods._id' => item_id).and('proposal.goods.outdated' => false)
    extract_products_from_offers_array(offers_array, item_id)
  end

  def search_in_offers_products_to_withdraw(item_id)
    offers_array = Offer.where('proposal.goods._id' => item_id)
    extract_products_from_offers_array(offers_array, item_id)
  end

  def search_in_negotiations_products_to_outdate(item_id)
    negotiations_array = Negotiation.where('proposals.goods._id' => item_id).and('proposals.goods.outdated' => false)
    extract_products_from_negotiations_array(negotiations_array, item_id)
  end

  def search_in_negotiations_products_to_withdraw(item_id)
    negotiations_array = Negotiation.where('proposals.goods._id' => item_id)
    extract_products_from_offers_array(negotiations_array, item_id)
  end

  def extract_products_from_offers_array(offers_array, item_id)
    products = []
    offers_array.each do |offer|
      products = offer.proposal.goods.where(id:item_id)
    end
    products
  end

  def extract_products_from_negotiations_array(negotiations_array, item_id)
    products = []
    negotiations_array.each do |negotiation|
      negotiation.proposals.each do |proposal|
        products = proposal.goods.where(id:item_id)
      end
    end
    products
  end

  def outdate_products(products)
    products.each do |product|
      product.outdated = true
    end
  end

  def withdraw_products(products)
    products.each do |product|
      product.withdraw
    end
  end

  def save_products(products)
    products.each do |product|
      product.valid? ? product.save : false
    end
  end

  def save_item(item)
    item.valid? ? item.save : false
  end
end
