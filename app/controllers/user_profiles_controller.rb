class UserProfilesController < ApplicationController

  def update
    user = current_user
    @user_profile = user.user_profile
    if @user_profile.user_id != current_user.id
      redirect_to root_path and return
    end
    @user_profile.attributes = user_profile_params
    if @user_profile.save!
      flash[:notice] = "Profile updated successfully"
      redirect_to root_path
    else
      flash[:alert] = "Error updating profile."
      redirect_to root_path
    end
  end

  private

  def user_profile_params
    my_params = params.require(:user_profile).permit(:display_name, :gender, :city, :state, :zip,
                                                    :address, :address2, :phone, :bio, :user_id, :birthdate,
                                                    :contact_email, :contact_phone)
  end
end
