class Users::RegistrationsController < Devise::RegistrationsController
  def create
    builder = UserBuilder.new
                         .email(params[:user][:email])
                         .password(params[:user][:password])
    user = builder.build

    respond_to do |format|
      if user
        user.save
        format.html { redirect_to offers_url }
        #format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
