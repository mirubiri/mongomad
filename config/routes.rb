Mongomad::Application.routes.draw do

  #La ruta por defecto sera a la pantalla inicial de la plataforma
  root :to => 'home#show'

  #Recursos del user
  resources :users do
    get 'user_caption'

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
      collection do
        post 'pusher_message'
      end
    end

    resources :deals do
      collection do
        post 'pusher_message'
      end
    end
    resources :alerts
  end

end
