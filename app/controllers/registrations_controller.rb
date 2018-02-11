class RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :organization, :password, :password_confirmation, :organization_name)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :organization, :password, :password_confirmation, :current_password)
  end

end
