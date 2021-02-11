Rails.application.routes.draw do

  resources :pasos
  resources :tutoriales
  resources :encabezados
  resources :columnas
  resources :herencias
  resources :coautores
  resources :administradores
  resources :configuraciones

  resources :archivos
  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
    match :sel_archivo, via: :get, on: :collection
  end
  resources :carpetas do
    match :seleccion, via: :get, on: :collection
    match :asigna, via: :post, on: :collection
    match :remueve_carpeta, via: :get, on: :member
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
  resources :especificaciones do
    match :nuevo, via: :post, on: :collection
  end
  resources :etapas do
    resources :tablas
    resources :especificaciones
  end
  resources :evaluaciones
  resources :idiomas do 
    resources :revistas
  end
  resources :imagenes
  resources :ingresos
  resources :instituciones do
    resources :departamentos
    resources :registros
  end
  resources :investigadores do
    match :perfil, via: :get, on: :member
  end
  resources :lineas do
    resources :archivos
    resources :imagenes
  end
  resources :metodologias do
    match :nuevo, via: :post, on: :collection
  end
  resources :observaciones do
    match :nuevo, via: :post, on: :collection
  end
  resources :origenes
  resources :perfiles
  resources :procesos
  resources :proyectos do
    match :nuevo, via: :post, on: :collection
    match :nuevo_tema_proyecto, via: :post, on: :collection
    resources :versiones
    resources :etapas
  end
  resources :publicaciones do
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
  resources :tablas do 
    match :cargar_tabla, via: :get, on: :member
  end
  resources :temas do
    match :nuevo, via: :post, on: :collection
    match :remueve_tema, via: :get, on: :member
  end
  resources :tema_ayudas do
    match :nuevo, via: :post, on: :collection
  end
  resources :textos do
    match :nuevo, via: :post, on: :collection
    match :agregar_tema, via: :post, on: :collection
    match :eliminar_tema, via: :post, on: :collection
    match :remueve_texto, via: :get, on: :member
  end
  resources :versiones

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'publicaciones#index'

end
