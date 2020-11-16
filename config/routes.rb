Rails.application.routes.draw do

  resources :agregaciones
  devise_for :usuarios
  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
  end
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
      match :sel_archivo_carga, via: :get
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

  root 'cargas#index'

end
