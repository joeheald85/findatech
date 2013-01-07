Findatech::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations'}

  root :to => "home#index"

  resources :users do
    collection do
      get :dashboard
      get :settings
      post :delete_photo
      post :get_my_schedule
      post :get_availability
      post :set_availability
      post :update_availability
      post :remove_availability
    end
    get :availability
    put :change_photo
    get :profile
    get :schedule_appointment
    get :schedule
    post :update_schedule
    post :sync_to_gcal
  end

  #admin routes
  match 'admins/dashboard/' => 'admins/admin#dashboard'
  namespace :admins do
     resources :users do
       post :reset_password
       post :lock_user
       post :unlock_user
       get :set_featured_tech
     end
  end
  
end
