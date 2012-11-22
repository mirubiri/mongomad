class UserdsController < ApplicationController
  # GET /userds
  # GET /userds.json
  def index
    @userds = Userd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @userds }
    end
  end

  # GET /userds/1
  # GET /userds/1.json
  def show
    @userd = Userd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @userd }
    end
  end

  # GET /userds/new
  # GET /userds/new.json
  def new
    @userd = Userd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @userd }
    end
  end

  # GET /userds/1/edit
  def edit
    @userd = Userd.find(params[:id])
  end

  # POST /userds
  # POST /userds.json
  def create
    @userd = Userd.new(params[:userd])

    respond_to do |format|
      if @userd.save
        format.html { redirect_to @userd, notice: 'Userd was successfully created.' }
        format.json { render json: @userd, status: :created, location: @userd }
      else
        format.html { render action: "new" }
        format.json { render json: @userd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /userds/1
  # PUT /userds/1.json
  def update
    @userd = Userd.find(params[:id])

    respond_to do |format|
      if @userd.update_attributes(params[:userd])
        format.html { redirect_to @userd, notice: 'Userd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @userd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userds/1
  # DELETE /userds/1.json
  def destroy
    @userd = Userd.find(params[:id])
    @userd.destroy

    respond_to do |format|
      format.html { redirect_to userds_url }
      format.json { head :no_content }
    end
  end
end
