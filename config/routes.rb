Mongomad::Application.routes.draw do
  #Devise gestiona a los usuarios y sus sesiones
  devise_for :users

  #La ruta por defecto sera a la pantalla inicial de la plataforma
  devise_scope :user do
    root to: "users#show"
  end

  authenticated :user do
    root :to => 'users#show'
  end

  #Recursos del user
  resources :users do
    resource :profile
    resources :requests
    resources :things
    resources :offers
    resources :negotiations
    resources :deals
  end

end
