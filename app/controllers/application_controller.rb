class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource_or_scope)
    if current_user.active
      if current_user.role? 'admin'
         return admins_dashboard_url
      else
         return dashboard_users_url
      end
    else
      sign_out(current_user)
      flash[:notice] =  "Your account has been locked. Please contact the site administrator if you have any questions. An admin may unlock account if he/she sees fit."
      return new_user_session_url
    end
  end
end
