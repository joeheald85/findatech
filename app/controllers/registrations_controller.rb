class RegistrationsController < Devise::RegistrationsController
 
 def create
   super # this calls Devise::RegistrationsController#create
   resource.roles << Role.find_by_role((params[:role] and params[:role][:tech] == "1") ? 'tech' : 'user')
   resource.save(:validate => false)
 end
 
end