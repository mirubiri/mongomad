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
      end
    end

    resources :deals
    resources :alerts
  end

  match 'negotiations/pusher_message' => 'negotiations#pusher_message', :as => 'pusher_message'

end
