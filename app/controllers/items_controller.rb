class ItemsController < ApplicationController
  def index
    @user = User.find(params[:user_id])

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
    @item = Item.new(user:@user, name:params[:item][:name], description:params[:item][:description])
    @item.images << Fabricate.build(:image_face, id:Cloudinary::Uploader.upload(params[:item][:image])["public_id"])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @user.items << @item
        format.html { redirect_to user_items_url, notice: 'item was successfully created.' }
        format.js { render 'add_item_in_list', :layout => false, :locals => { :item => @item }, :status => :created }
      else
        format.html { render action: "index" }
      end
    end
  end

  def update
    #TODO: REVISAR
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @item.save
        format.html { redirect_to user_items_path(@user), notice: 'item was successfully updated.' }
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
        format.html { redirect_to user_items_url }
      else
        # ni idea :)
      end
    end
  end
end
