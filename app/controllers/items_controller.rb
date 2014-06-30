class ItemsController < ApplicationController

  def index
    @data.viewed_user_items = Item.where(user_id:@data.viewed_user.id)

    respond_to do |format|
      format.html
      #format.json { render json: @data.items }
    end
  end

  def show
    @data.item = Item.find(params[:id])

    respond_to do |format|
      format.html
      #format.json { render json: @data.item }
    end
  end

  def new
    @data.item = Item.new

    respond_to do |format|
      format.html
      #format.json { render json: @data.item }
    end
  end

  def edit
    @data.item = Item.find(params[:id])
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
        #format.json { render json: @data.item, status: :created, location: @data.item }
      else
        format.html { render action: "new" }
        #format.json { render json: @data.item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    item = Item.find(params[:id])
    item.images = []
    params[:item][:images].delete({"id"=>"nil"})

    builder = ItemBuilder.new(item)
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
        #format.json { render json: @data.item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      #format.json { head :no_content }
    end
  end
end
