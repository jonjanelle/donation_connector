class User < ApplicationRecord
  rolify
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_create :sanitize_email
  after_create :assign_role
  after_create :create_user_profile
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  has_one :user_profile, dependent: :destroy
  has_many :donations, inverse_of: :user
  has_many :donation_requests, inverse_of: :user

  def sanitize_email
    self.email = self.email.strip.downcase
  end

  #admin roles assigned through console
  def assign_role
    if self.organization
      self.add_role :organization if self.roles.blank?
    else
      self.add_role :standard if self.roles.blank?
    end
  end

  def create_user_profile
    up = UserProfile.new(user_id: self.id)
    up.display_name = self.organization_name if self.organization
    up.save(validate: false)
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end


end
