Mongomad::Application.routes.draw do
  #Devise gestiona a los usuarios y sus sesiones
  #devise_for :users

  #La ruta por defecto sera a la pantalla inicial de la plataforma
  root :to => 'home#show'

  #Recursos del user
  resources :users do
    resource :profile
    resources :requests
    resources :items
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

  match 'negotiations/updateComments' => 'negotiations#updateComments', :via => :get
  match 'offers/updateOffers' => 'offers#updateOffers', :via => :get

end
