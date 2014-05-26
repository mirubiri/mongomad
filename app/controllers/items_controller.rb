class ItemsController < ApplicationController

  layout 'exposition'

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    @requests = Request.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    preloaded_file = Cloudinary::PreloadedFile.new(params[:image_id])
    builder = ItemBuilder.new
                         .user(current_user)
                         .images([{ id:preloaded.public_id, main:true }])
                         #.name(params[:item][:name])
                         #.description(params[:item][:description])
    item = builder.build

    respond_to do |format|
      if item
        item.save
        format.html { redirect_to items_url }
        format.json { render json: @item, status: :created, location: @item }
      else
        #builder.errors
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to offers_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
