Rails.application.routes.draw do

  devise_for :usuarios
  resources :agregaciones
  resources :autores
  resources :conceptos
  resources :departamentos do
    resources :investigadores
  end
  resources :idiomas do 
    resources :revistas
  end
  resources :instituciones do
    resources :departamentos
    resources :registros
  end
  resources :investigadores
  resources :metodologias
  resources :origenes
  resources :publicaciones do
    resources :textos
    resources :metodologias
  end
  resources :recursos do
    collection do
      match :inicia_sesion, via: :get
      match :tablas, via: :get
    end
  end
  resources :referencias
  resources :registros do
    resources :publicaciones
  end
  resources :repositorios do
    resources :origenes
  end
  resources :revistas do
    resources :publicaciones
  end
  resources :textos

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'recursos#tablas'

end
