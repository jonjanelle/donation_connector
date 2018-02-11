class DonationItem < ApplicationRecord

  def resource
    self.resource_type.constantize.where(id: self.resource_id)
  end

end
