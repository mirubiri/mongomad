class ItemsController < ApplicationController

  layout 'exposition'

  def index
    @items = Item.all
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @items }
    end
  end

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html
      #format.json { render json: @item }
    end
  end

  def new
    @item = Item.new
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    if params[:image1].present?
      preloaded_file = Cloudinary::PreloadedFile.new(params[:image1])         
      params[:item][:images][0][:id] = preloaded_file.public_id
    end

    if params[:image2].present?
      preloaded_file = Cloudinary::PreloadedFile.new(params[:image2])         
      params[:item][:images][1][:id] = preloaded_file.public_id
    end

    if params[:image3].present?
      preloaded_file = Cloudinary::PreloadedFile.new(params[:image3])         
      params[:item][:images][2][:id] = preloaded_file.public_id
    end

    builder = ItemBuilder.new
                         .user(current_user)
                         .images(params[:item][:images])
                         .name(params[:item][:name])
                         .description(params[:item][:description]) 
    item = builder.build

    respond_to do |format|
      if item
        item.save
        format.html { redirect_to items_url }
        #format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        #format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to offers_url }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      #format.json { head :no_content }
    end
  end
end
