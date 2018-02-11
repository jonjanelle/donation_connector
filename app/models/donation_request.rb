class DonationRequest < ApplicationRecord
  belongs_to :user
  has_many :donations, inverse_of: :donation_request
  def contact_name
    "#{self.contact_first} #{self.contact_last}"
  end

  def donation_items
    DonationItem.where(resource_type: DonationRequest.name, resource_id: self.id)
  end

  def date_created
    self.created_at.strftime("%b %e, %Y")
  end
end
