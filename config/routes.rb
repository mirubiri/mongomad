Mongomad::Application.routes.draw do

  #Devise gestiona a los usuarios y sus sesiones
  devise_for :users

  devise_scope :user do 
    match "/" => "devise/sessions#new" 
  end

  #La ruta por defecto sera a la pantalla inicial de la plataforma
  root :to => "devise/sessions#new"  

  #Recursos del user
  resources :users do
    resources :profile do
      resources :image
    end
    resources :requests 
    resources :things do
      resources :images
    end   
    resources :offers do
      resources :images, :composer, :receiver, :money
    end
    resources :negotiations do
      resources :proposals, :messages
    end
    resources :deals do
      resources :agreement, :messages
    end   
  end


end
