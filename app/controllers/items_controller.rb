class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @user = User.find(params[:user_id])
    @item = Item.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # renders index.js.erb
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @user = User.find(params[:user_id])
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  # GET /items/1/edit
  def edit
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb
    end
  end

  # POST /items
  # POST /items.json
  def create
    @user = User.find(params[:user_id])
    @item = Item.new(params[:user_item])

    respond_to do |format|
      if @user.items << @item
        format.html { redirect_to user_items_url, notice: 'item was successfully created.' }
        format.js { render 'add_item_in_list', :layout => false, :locals => { :item => @item }, :status => :created }
      else
        error = @item.errors.to_a
        flash[:message] = error
        format.html { render action: "index" }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:user_item])
        format.html { redirect_to user_items_path(@user), notice: 'item was successfully updated.' }
        format.js { render 'reload_items', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to user_items_url }
    end
  end
end
