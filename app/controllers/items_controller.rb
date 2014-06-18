class ItemsController < ApplicationController

  layout 'exposition'

  def index
    # @items = Item.where(user_id:current_user.id)
    # @requests = Request.where(user_id:current_user.id)
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
    # @requests = Request.where(user_id:current_user.id)
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
    # @requests = Request.where(user_id:current_user.id)
    @requests = Request.all
  end

  def create
    params[:item][:images].delete({"id"=>"nil"})
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
    @item.images = []
    params[:item][:images].delete({"id"=>"nil"})

    builder = ItemBuilder.new(@item)
                         .images(params[:item][:images])
                         .name(params[:item][:name])
                         .description(params[:item][:description])
    item = builder.build

    respond_to do |format|
      if item
        item.save
        format.html { redirect_to items_url }
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
