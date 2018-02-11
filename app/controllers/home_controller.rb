class HomeController < ApplicationController

  def index
    if user_signed_in?
      @user = current_user
      @user_profile = @user.user_profile
      if current_user.organization
        @donation_requests = DonationRequest.where(user_id: current_user.id).includes(:donations)
        @donations = @donation_requests.map(&:donations).flatten
        @items_received = DonationItem.where(resource_type: Donation.name, resource_id: @donations.map(&:id))
      else
      end
    end
  end

  def nearby_organizations
    @orgs = User.where(organization: true)
  end

end
