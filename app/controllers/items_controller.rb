class ItemsController < ApplicationController

  layout 'exposition'

  def index
    @items = Item.all
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def new
    @item = Item.new
    @requests = Request.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    preloaded_file1 = Cloudinary::PreloadedFile.new(params[:image_id1])
    preloaded_file2 = Cloudinary::PreloadedFile.new(params[:image_id2])
    preloaded_file3 = Cloudinary::PreloadedFile.new(params[:image_id3])

    builder = ItemBuilder.new
                         .user(current_user)
                         .images([{ id:preloaded_file1.public_id, main:false },
                                  { id:preloaded_file2.public_id, main:true },
                                  { id:preloaded_file3.public_id, main:false }])
                         .name(params[:item][:name])
                         .description(params[:item][:description])

    item = builder.build

    respond_to do |format|
      if item
        item.save
        format.html { redirect_to items_url }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
