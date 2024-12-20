Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users,
        controllers: {
          sessions: 'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations'
        },
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        }
      
      resources :referrals, only: [:create]
    end
  end
end
