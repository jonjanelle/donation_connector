class DonationsController < ApplicationController
  before_action :set_donation, only: [:edit, :update, :show, :destroy]

  # List all donation requests.
  # User can select a donation request to create a new donation.
  def index
    @donation_requests = DonationRequest.all
    #@donations = Donation.all
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    if @donation.save
      flash[:notice] = "Donation created successfully. Thanks!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to root_path, notice: 'Donation updated successfully!' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    items = DonationItem.where(resource_type: Donation.name, resource_id: @donation.id)
    items.map(&:destroy)
    @donation.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  def set_donation
    @donation = Donation.find(params[:id])
  end

  private

  def donation_params
    params.require(:donation).permit(:from_id, :to_id, :delivery_time, :contact_first, :contact_last, :contact_email, :contact_phone)
  end
end
