Mongomad::Application.routes.draw do
  #Devise gestiona a los usuarios y sus sesiones
  devise_for :users

  #La ruta por defecto sera a la pantalla inicial de la plataforma
  root :to => 'users#show'

  #Recursos del user
  resources :users do
    resource :profile
    resources :requests
    resources :things
    resources :offers

    resources :negotiations do
      member do
        get 'sign'
        get 'confirm'
        get 'cancel'
      end
    end

    resources :deals
    resources :alerts
  end
end
