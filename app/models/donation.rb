class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :donation_request, inverse_of: :donations
  def donation_items
    DonationItem.where(resource_type: DonationRequest.name, resource_id: self.id)
  end

end
