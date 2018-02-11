class DonationRequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy, :edit, :add_items]

  def new
    @donation_request = DonationRequest.new
    @user = current_user
    @user_profile = @user.user_profile
    @item_categories = ["Food", "Clothing", "Home Goods", "Electronics", "Cleaning Supplies", "Transportation", "Other"]
  end

  def create
    @donation_request = DonationRequest.new(donation_request_params)

    @donation_request.user_id = current_user.id
    if @donation_request.save
      params[:items].to_unsafe_hash.each do |key, item|
        date = Date.parse(item["date"]) if item["date"].present? || nil
        DonationItem.create(resource_type: DonationRequest.name, resource_id: @donation_request.id, name: item["name"],
                            category: item["category"], quantity: item["quantity"], start_availability: date,
                            urgent: item["urgent"].present?, notes: item["notes"])
      end
      flash[:notice] = "Donation request created successfully."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @donation_request.update(donation_request_params)
        format.html { redirect_to root_path, notice: 'Donation request updated successfully!' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def index
  end

  def show
  end

  def destroy
    #destroy dependent DonationItems
    items = DonationItem.where(resource_type: DonationRequest.name, resource_id: @donation_request.id)
    items.map(&:destroy)
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
    @donation_request.destroy
  end

  def add_items
  end

  def set_request
    @donation_request = DonationRequest.find(params[:id])
  end
  private

  def donation_request_params
    params.require(:donation_request).permit(:user_id, :description, :notes, :contact_first, :contact_last, :contact_email, :contact_phone)
  end

end
