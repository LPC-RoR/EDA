Rails.application.routes.draw do
  resources :sumarios
  resources :alcances
  # SCOPE APLICACION
  scope module: 'aplicacion' do
    resources :archivos
    resources :documentos do
      resources :archivos
    end
    resources :imagenes
    resources :administradores
#    resources :mejoras
    resources :observaciones do
      match :nuevo, via: :post, on: :collection
    end
    resources :perfiles do
      match :desvincular, via: :get, on: :member
    end
    resources :recursos do
      collection do
        match :home, via: :get
        match :inicia_sesion, via: :get
        match :bibliografia, via: :get
        match :procesos, via: :get
        match :administracion, via: :get
        match :borrar_archivos, via: :get
      end
    end
    resources :licencias
  end

  # SCOPE HELP
  scope module: 'help' do
#    resources :conversaciones
    resources :mensajes
    resources :pasos
    resources :tema_ayudas do
      resources :tutoriales
    end
    resources :tutoriales do
      resources :pasos
    end
  end

  scope module: 'data' do
    resources :datos
    resources :etapas do
      resources :tablas
    end
    resources :tablas do 
          resources :observaciones
      match :cargar_tabla, via: :get, on: :member
      match :descargar_tabla, via: :get, on: :member
    end
    resources :especificaciones do
      match :nuevo, via: :post, on: :collection
    end
    resources :lineas do
      resources :archivos
      resources :imagenes
      resources :observaciones
    end
    resources :columnas
    resources :encabezados

    resources :subs
    resources :directorios do
      match :nuevo, via: :post, on: :collection
    end
    resources :opciones
    resources :caracteristicas
    resources :caracterizaciones do
      resources :caracteristicas
      match :crear_tabla, via: :get, on: :member
      match :eliminar_tabla, via: :get, on: :member
    end
  end

  resources :etq_contadores
  resources :etiquetas do
    match :nuevo, via: :post, on: :collection
    match :asignar, via: :get, on: :member
    match :desasignar, via: :get, on: :member
  end
  resources :tipo_publicaciones do
    resources :campos
  end
  resources :campos
  resources :formatos

  resources :campo_cargas
  resources :formato_cargas do
    resources :campo_cargas
  end

  resources :asociaciones
  resources :relaciones
  resources :herencias
  resources :coautores

  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
  end
  resources :carpetas do
    match :nuevo, via: :post, on: :collection
    match :seleccion, via: :get, on: :collection
    match :elimina, via: :post, on: :collection
    match :desasigna_carpeta, via: :get, on: :member
    match :elimina_carpeta, via: :get, on: :member
    match :btn_asigna, via: :get, on: :member
    match :nueva_carpeta_reporte, via: :post, on: :collection
    match :sacar_carpeta, via: :get, on: :member
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
  resources :instituciones do
    resources :departamentos
    resources :registros
  end
  resources :investigadores do
    match :perfil, via: :get, on: :member
  end
  resources :origenes
  resources :procesos
  resources :proyectos do
    match :nuevo, via: :post, on: :collection
    match :nuevo_tema_proyecto, via: :post, on: :collection
    match :asigna_tema_proyecto, via: :post, on: :collection
    match :elimina_tema_proyecto, via: :post, on: :collection
    match :activo, via: :get, on: :member
    resources :versiones
    resources :etapas
    resources :carpetas
    scope module: :aplicacion do
        resources :documentos
    end    
  end
  resources :publicaciones do
    match :cambia_evaluacion, via: :get, on: :member
    match :cambia_tipo, via: :get, on: :collection
    match :estado, via: :get, on: :collection
    resources :textos
  end
  resources :registros do
    resources :publicaciones
  end
  resources :reportes do
    match :xlsx, via: :get, on: :member
  end
  resources :repositorios do
    end
  resources :revistas do
    resources :publicaciones
  end
  resources :temas do
    match :nuevo, via: :post, on: :collection
    match :desasignar, via: :get, on: :member
    match :eliminar, via: :get, on: :member
  end
  resources :textos do
    match :nuevo, via: :post, on: :collection
    match :agregar_tema, via: :post, on: :collection
    match :eliminar_tema, via: :post, on: :collection
    match :desasignar, via: :get, on: :member
  end
  resources :versiones

  devise_for :usuarios, controllers: {
        confirmations: 'usuarios/confirmations',
#        omniauth_callbacks: 'usuarios/omniauth_callbacks',
        passwords: 'usuarios/passwords',
        registrations: 'usuarios/registrations',
        sessions: 'usuarios/sessions',
        unlocks: 'usuarios/unlocks'
      }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'aplicacion/recursos#home'

end
