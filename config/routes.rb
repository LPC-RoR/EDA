Rails.application.routes.draw do

  resources :herencias
  resources :coautores
  resources :administradores
  resources :configuraciones
  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
    match :sel_archivo, via: :get, on: :collection
  end
  resources :carpetas do
    match :seleccion, via: :get, on: :collection
  end
  resources :citas
  resources :clasificaciones do
    match :clasifica, via: :get, on: :member
  end
  resources :departamentos do
    resources :investigadores
  end
  resources :equipos do
    match :nuevo, via: :post, on: :collection
  end
  resources :evaluaciones
  resources :idiomas do 
    resources :revistas
  end
  resources :ingresos
  resources :integrantes
  resources :instituciones do
    resources :departamentos
    resources :registros
  end
  resources :investigadores do
    match :perfil, via: :get, on: :member
  end
  resources :metodologias do
    match :nuevo, via: :post, on: :collection
  end
  resources :origenes
  resources :perfiles
  resources :procesos
  resources :proyectos do
    match :nuevo, via: :post, on: :collection
    match :nuevo_tema_proyecto, via: :post, on: :collection
  end
  resources :publicaciones do
    match :cambia_carpeta, via: :get, on: :collection
    match :cambia_evaluacion, via: :get, on: :member
    match :cambia_tipo, via: :get, on: :collection
    match :estado, via: :get, on: :collection
    resources :textos
  end
  resources :recursos do
    collection do
      match :inicia_sesion, via: :get
      match :tablas, via: :get
      match :manual, via: :get
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
    match :remueve_texto, via: :get, on: :member
  end

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'perfiles#inicia_sesion'

end
