class DealsController < ApplicationController
  # GET /deals
  # GET /deals.json
  def index
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(params[:deal])

    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    @deal = Deal.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
    end
  end
end
