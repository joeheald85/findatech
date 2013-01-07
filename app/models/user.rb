class User < ActiveRecord::Base
  has_many :user_roles
  has_many :roles, :through => :user_roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :city, :state, :zip, :rate, :distance, :timezone, :full_name
                  
  validates_format_of :email, :with  => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => false, :if => :email_changed?
  validates :email, :uniqueness => { :message => "is already taken" }
  validates :username, :uniqueness => { :message => "is already taken" }
  validates_presence_of :email, :username, :password, :password_confirmation, :on => :create
  validates_confirmation_of :password, :on => :create
  
  def role?(role)
    role = Role.find_by_role(role)
    if role and self.roles.include?(role)
      return true
    else
      return false
    end
  end
end
