class ThingsController < ApplicationController
  # GET /things
  # GET /things.json

  def sub_layout
    "things"
  end

  def index
    @user = User.find(params[:user_id])
    @things = @user.things.to_a
    @thing = User::Thing.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # renders index.js.erb
    end
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @thing = Thing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/new
  # GET /things/new.json
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @user = User.find(params[:user_id])
    @thing = @user.things.find(params[:id])
  end

  # POST /things
  # POST /things.json
  def create
    @user = User.find(params[:user_id])
    #@thing = current_user.things.build(params[:user_thing]) 
    @thing = current_user.things.build(image: params[:image],
                                       name: params[:name],
                                       description: params[:description],
                                       stock: params[:stock]) 

    respond_to do |format|
      if @thing.save
        flash[:message] = "woww, anda que funciona"   
        format.html { redirect_to user_things_url, notice: 'thing was successfully created.' }
        format.json { render json: user_things_url, status: :created}
      else
        error = @thing.errors.to_a
        flash[:message] = error
        format.html { render action: "index" }
        format.json { render json: @thing.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.json
  def update
    @thing = Thing.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        format.html { redirect_to @thing, notice: 'thing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing = Thing.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to user_things_url }
      format.json { head :no_content }
    end
  end


end
