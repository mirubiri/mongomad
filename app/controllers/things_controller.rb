class ThingsController < ApplicationController
  # GET /things
  # GET /things.json

  def sub_layout
    "things"
  end

  def index
    @user = current_user
    @things = @user.items.to_a
    @thing = Item.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # renders index.js.erb
    end
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @thing = current_user.things.find(params[:id])
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /things/new
  # GET /things/new.json
  def new
    @thing = Item.new
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  # GET /things/1/edit
  def edit
    @thing = current_user.things.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb
    end
  end

  # POST /things
  # POST /things.json
  def create
    @thing = Item.new(params[:user_thing])

    respond_to do |format|
      if current_user.things << @thing
        format.html { redirect_to user_things_url, notice: 'thing was successfully created.' }
        format.js {
          render :partial => "things/reload_things_list", :layout => false, :locals => { :thing => @thing }, :status => :created
        }
      else
        error = @thing.errors.to_a
        flash[:message] = error
        format.html { render action: "index" }
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.json
  def update
    @user = current_user
    @thing = current_user.things.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:user_thing])
        format.html { redirect_to user_things_path(current_user), notice: 'thing was successfully updated.' }
        format.js { render :partial => "things/edit_thing_in_list", :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing = Item.find(params[:id])
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to user_things_url }
    end
  end


end
