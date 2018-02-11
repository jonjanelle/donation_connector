class UserProfile < ApplicationRecord
  belongs_to :user
  
  def display_city_state
    if self.city.present? && self.state.present?
      "#{city.titleize}, #{state}"
    else
      nil
    end
  end

  def age_in_years
    if birthdate.present?
      ((Date.today - self.birthdate)/365.0).to_i
    else
      nil
    end
  end

end
