class ProfilesController < ApplicationController

  def show
    @profile = Profile.new
    # @requests = Request.where(user_id:current_user.id)
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @items }
    end
  end

  def edit
    # @requests = Request.where(user_id:current_user.id)
    @requests = Request.all

    if params[:image].present?
      preloaded_file = Cloudinary::PreloadedFile.new(params[:image])
      params[:profile][:images] = preloaded_file.public_id
    end

    builder = UserBuilder.new(current_user)
                         .first_name(params[:profile][:first_name])
                         .last_name(params[:profile][:last_name])
                         .location(params[:profile][:location])
                         #.images(params[:profile][:images])
    user = builder.build

    respond_to do |format|
      if user
        user.save
        format.html
      else
        format.html
      end
    end
  end
end
