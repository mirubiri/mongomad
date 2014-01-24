Mongomad::Application.routes.draw do

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
        get 'pusher_message'
      end
    end

    resources :deals
    resources :alerts
  end

end
