require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eda
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # +++ HCH activa locala :es
    config.i18n.default_locale = :es


    ## ------------------------------------------------- CAPITAN

    ## ------------------------------------------------- STANDARD

    ## comportamiento por defecto de los elementos de una tabla
    # Se verifica con el helper in_t?(c, label)
    config.t_default = {
        titulo:  {'self' => true,  'show' => false},
        tabs:    {'self' => false, 'show' => false}, 
        estados: {'self' => false, 'show' => false},
        paginas: {'self' => false, 'show' => false},
        nuevo:   {'self' => true,  'show' => false}
    }

    # Se verifica con el helper in_show?(c, label)
    config.s_default = {
        titulo:       true,
        links:        true,
        clasifica:   false,
        detalle:     false,
        inline_form: false,
        tabla:        true,
        adjuntos:    false
    }
    ## ------------------------------------------------- MENU
    # controladores que NO despliegan MENU
    # se usa en nomenu?
    config.x.menu.exceptions_controllers = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']    

    ## Menu principal de la aplicación
    # [0] : Item del menú
    # [1] : Link del ítem
    # [2] : Tipo de ítem {'admin', 'usuario', 'anonimo', 'excluir'}
    # se usa directamente en 0p/navbar/_navbar.html.erb
    config.menu = [
        ["Publicaciones", "/publicaciones",   'usuario'],
        ["Equipos",       "/equipos",         'excluir'],
        ["Proyectos",     "/proyectos",       'usuario'],
        ["Carpetas",      "/carpetas",        'usuario'],
        ["Temas",         "/temas",           'usuario'],
        ["Textos",        "/textos",          'usuario'],
        ["Ingresos",      "/ingresos",        'usuario'],
        ["Cargas",        "/cargas",          'usuario'] 
    ]

    ## ------------------------------------------------- FRAMES
    config.frames = {
        'publicaciones' => {
            'index' => {
                titulo: 'Publicaciones',
                selector: 'Carpetas',
                action_type: 'tabla'
            }

        },
        'ingresos' => {
            'index' => {
                titulo: 'Ingresos',
                action_type: 'tabla',
                tabs: ['ingreso', 'duplicado', 'papelera']
            }
        }
    }

    ## ------------------------------------------------- TABLA

    config.x.tables.bt_fields = {
        'Modelo' => {
            'field' => ['field_type', 'bt_object']
        },
        'Clasificacion' => {
            'texto' => ['bt_field', 'texto']
        }
    }

    config.x.tables.exceptions = {
        'publicaciones' => {
            elementos: {
                titulo:  ['self'],
                paginas: ['*'],
                nuevo:   ['self', 'ingresos']
            }
        },
        'textos'        => {
            elementos: {
                nuevo:    ['self']
            }

        },
        'proyectos'     => {
            elementos: {
                tabs:    ['self']
            },
            tabs: ['Administrados', 'Participaciones'],
            new_type: {
                #'controller' => 'tipo_new'
                # '*' en todo controller_name
                '*' => 'inline'
            }
        }
    }

    ## ------------------------------------------------- TABLA | BTNS

    ## x_btns
    # [0] : Nombre del boton
    # [1] : link base, a esta base se le agrega el instancia_id
    # [2] : Si es true se agrega "objeto_id=#{@objeto.id}"

    config.x.btns.exceptions = {
        'Publicacion'   => {
            conditions: ['crud']
        },
        'Carpeta'       => {
            conditions: ['crud']
        },
        'Carga'         => {
            conditions: ['x', 'crud'],
            x_btns: [   
                ['Proceso', '/cargas/', '/procesa_carga', false]
            ]
        },
        'Texto'         => {
            conditions: ['x', 'crud'],
            x_btns: [
                ['Eliminar', '/textos/', '/remueve_texto', true]
            ],
        },
        'Clasificacion' => {
            conditions: ['x', 'crud'],
            x_btns: [
                ['referencia',     '/clasificaciones/', '/clasifica?clasificacion=referencia'    , true],
                ['complementario', '/clasificaciones/', '/clasifica?clasificacion=complementario', true],
                ['controversial',  '/clasificaciones/', '/clasifica?clasificacion=controversial' , true],
                ['revisar',        '/clasificaciones/', '/clasifica?clasificacion=revisar'       , true]
            ]
        }
    }

    ## ------------------------------------------------- FORM

    # estan condiciones se aplican a FORM y SHOW
    config.x.form.exceptions = {
        'Publicacion' => {
            f_detail: true,
            conditional_fields: [
                'd_quote',
                'm_quote',
                'd_author',
                'title',
                'author',
                'd_journal',
                'journal',
                'year',
                'volume',
                'pages',
                'd_doi',
                'doi',
                'abstract',
                'book',
                'editor',
                'academic_degree',
                'ciudad_pais'
            ]
        }
    }

    ## ------------------------------------------------- SHOW

    config.x.show.exceptions = {
        'Publicacion' => {
            elementos: [:clasifica, :detalle, :inline_form, 'show_title'],
        },
        'Proyecto'     => {
            elementos: [:detalle, :inline_form]
        }
    }

    config.x.show.links = {
        links:     ['Publicacion'],
        bt_links:  ['Publicacion'],
        hmt_links: ['Publicacion'],
        bt_objects: {
            'Publicacion' => ['revista']
        },
        hmt_collections: {
            'Publicacion' => ['investigadores']
        }
    }

    config.x.show.hidden = {
        'publicaciones'  => ['citas', 'autores', 'investigadores', 'procesos', 'cargas', 'clasificaciones', 'carpetas', 'evaluaciones'],
        'textos'         => ['clasificaciones', 'citas'],
        'carpetas'       => ['clasificaciones'],
        'investigadores' => ['autores'],
        'temas'          => ['textos', 'herencias'],
        'proyectos'      => ['coautores', 'herencias']
    }

  end
end
