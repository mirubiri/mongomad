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
    @item = Item.new(name:params[:item][:name], description:params[:item][:description])

    params[:item][:images].each do |image_params|
      @image = Attachment::Image.new(main:image_params[:main])
      @image.id = image_params[:public_id]
      @item.images << @image
    end

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

    @item.name = params[:item][:name]
    @item.description = params[:item][:description]
    @item.images.all.delete

    puts "*******************************************************************************"
    puts @item.images.size
    puts "*******************************************************************************"

    params[:item][:images].each do |image_params|
      @image = Attachment::Image.new(main:image_params[:main])
      @image.id = image_params[:public_id]
      puts "*******************************************************************************"
      puts @image.valid?
      @item.images << @image
      puts "*******************************************************************************"
      puts @item.valid?
      puts @item.images.size
      puts "*******************************************************************************"
    end

    puts "*******************************************************************************"
    puts @item.persisted?
    puts "*******************************************************************************"

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @item.save
        @items = @user.items.desc(:updated_at)
        format.html { redirect_to user_items_path(@user), notice: 'Item has been successfully updated.' }
        format.js { render 'reload_items', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @item.destroy
        format.html { redirect_to user_items_url, notice: 'Item has been successfully deleted.' }
      else
        # ni idea :)
      end
    end
  end
end
