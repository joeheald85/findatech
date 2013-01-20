class User < ActiveRecord::Base
  before_save :reverse_geocode
  has_many :user_roles
  has_many :roles, :through => :user_roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
                  :city, :state, :zip, :rate, :distance, :timezone, :full_name, :profile_picture
                  
  validates_format_of :email, :with  => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => false, :if => :email_changed?
  validates :email, :uniqueness => { :message => "is already taken" }
  validates :username, :uniqueness => { :message => "is already taken" }
  validates_presence_of :email, :username, :password, :password_confirmation, :on => :create
  validates_presence_of :city, :state, :zip, :full_name
  validates_confirmation_of :password, :on => :create
  
  has_attached_file :profile_picture, :styles => { :large => "218x218#", :medium => "150x150#", :thumb => "50x50#", :tiny => "28x28#" },
                                      :url => "/system/profile_pictures/:id/:style/:normalized_file_name.:extension",
                                      :default_url => "/assets/avatar/missing_:style.jpg",
                                      :path => ":rails_root/public/system/profile_pictures/:id/:style/:normalized_file_name.:extension"
  
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance_from,
                   :lat_column_name => :lat,
                   :lng_column_name => :lon
                   
  Paperclip.interpolates :normalized_file_name do |attachment, style|
    attachment.instance.normalized_file_name
  end

  def normalized_file_name
    Digest::MD5.hexdigest(self.profile_picture_file_name+self.id.to_s)
  end
                   
  def reverse_geocode
    if !self.city.nil? and !self.state.nil?
      results = Geokit::Geocoders::GoogleGeocoder.geocode(self.city+', '+self.state)
      if !results.nil?
        self.lat = results.lat
        self.lon = results.lng
      end
    end
  end
  
  def role?(role)
    role = Role.find_by_role(role)
    if role and self.roles.include?(role)
      return true
    else
      return false
    end
  end
end
