class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :tech, :class_name => :User
end