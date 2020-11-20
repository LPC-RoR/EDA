Rails.application.routes.draw do

  resources :clasificaciones
  resources :citas
  resources :carpetas do
    match :seleccion, via: :get, on: :collection
  end
  resources :procesos
  devise_for :usuarios
  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
  end
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
    end
  resources :recursos do
    collection do
      match :inicia_sesion, via: :get
      match :tablas, via: :get
      match :sel_archivo_carga, via: :get
    end
  end
  resources :registros do
    resources :publicaciones
  end
  resources :repositorios do
    end
  resources :revistas do
    resources :publicaciones
  end
  resources :textos do
    match :nuevo, via: :post, on: :collection
    match :agregar_carpeta, via: :post, on: :collection
    match :eliminar_carpeta, via: :post, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'publicaciones#index'

end