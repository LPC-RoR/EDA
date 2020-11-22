Rails.application.routes.draw do

  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
  end
  resources :carpetas do
    match :seleccion, via: :get, on: :collection
  end
  resources :citas
  resources :clasificaciones
  resources :departamentos do
    resources :investigadores
  end
  resources :evaluaciones
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
  resources :procesos
  resources :publicaciones do
    match :mask_new, via: :get, on: :collection
    match :mask_nuevo, via: :post, on: :collection
    match :cambia_carpeta, via: :get, on: :collection
    match :cambia_evaluacion, via: :get, on: :collection
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
  resources :temas do
    match :nuevo, via: :post, on: :collection
  end
  resources :textos do
    match :nuevo, via: :post, on: :collection
    match :agregar_tema, via: :post, on: :collection
    match :eliminar_tema, via: :post, on: :collection
  end

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'publicaciones#index'

end
