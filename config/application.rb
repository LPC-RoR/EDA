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

    ## ------------------------------------------------- 0p
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

    ## ------------------------------------------------- APARIENCIA APLICACION

    config.look_app = {
        aplicacion: {
            favicon: true,
            banner: false,
            nombre_aplicacion: 'Eda',
            home_link: 'http://www.edasoft.cl',
            titulo_size: '1',
            titulo_color: 'primary',
            detalle_size: '6',
            detalle_color: 'primary',
            portada: {
                active: false,
                size: nil,
                clase: 'mx-auto d-block'
            },
            init: {
                size: 'half',
                clase: 'mx-auto d-block',
                titulo_size: 1,
                titulo_color: 'primary',
                detalle_size: 6,
                detalle_color: 'primary'
            },
            foot: {
                active: true,
                size: 'quarter',
                clase: 'mx-auto d-block'
            },
            help: {
                size: 'quarter',
                clase: 'mx-auto d-block'
            }
        },
        navbar: {
            color: 'primary',
            logo: true,
            nomenu_controllers: ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks'],
            item_contacto: true,
            item_ayuda: true
        },
        look_elementos: {
            app: {
                color: 'primary'
            },
            help: {
                color: 'secondary',
                controllers: ['tema_ayudas', 'tutoriales', 'pasos', 'mensajes']
            },
            data: {
                color: 'info',
                controllers: ['etapas', 'tablas', 'lineas', 'especificaciones', 'observaciones', 'archivos', 'imagenes']
            }
        }
    }

    ## ------------------------------------------------- TABLA

    config.tables = {
        exceptions: {
            titulo: {
                'publicaciones' => ['self'],
                'carpetas' => ['publicaciones', 'proyectos'],
                'temas' => ['publicaciones']
            },
            estados: {},
            tabs: {
                'publicaciones' => ['ingresos', 'publicaciones'],
                'proyectos' => ['self']
            },
            paginas: {
                'publicaciones' => ['*']
            },
            nuevo: {
                'publicaciones' => ['self', 'ingresos'],
                'textos' => ['self'],
                'versiones' => ['proyectos'],
                'carpetas' => ['publicaciones', 'proyectos'],
                'temas' => ['publicaciones']
            },
            inline_form: {
                'proyectos' => ['*']
            }
        },
        tabs: {
            'publicaciones' => {
                'ingresos' => ['ingreso', 'duplicado', 'papelera', 'publicada'],
                'publicaciones' => ['Selección', 'Proceso']
            },
            'proyectos' => {
                'proyectos' => ['Administrados', 'Participaciones']
            }
        },
        bt_fields: {
            'Clasificacion' => {
                'texto' => 'texto'
            },
            'Proyecto' => {
                'email' => 'administrador'
            }
        },
        alias: {
            'ingresos' => 'publicaciones'
        },
        sortable: {}
    }

    ## ------------------------------------------------- FORM

    config.form = {
        detail_types_controller: {
            help: ['mejoras', 'mensajes', 'observaciones', 'tema_ayudas', 'tutoriales', 'pasos'],
            data: ['especificaciones', 'tablas'],
            modelo: ['publicaciones']
        },
        conditional_fields: {
            'Publicacion' => [
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
            ],
            'Mensaje' => ['email']
        }
    }

    ## ------------------------------------------------- SHOW

    config.show = {
        titulo: [],
        show_title: ['Publicacion', 'Linea'],
        partial_links: [],
        detalle: [],
        inline_form: [],
        tabla: [],
        links: ['Publicacion'],
        bt_links: {
            'Publicacion' => ['revista']
        },
        hmt_links: {
            'Publicacion' => ['investigadores']
        },
        status: [],
        hidden: {
            'textos'         => ['clasificaciones', 'citas'],
            'carpetas'       => ['clasificaciones'],
            'investigadores' => ['autores'],
            'temas'          => ['textos', 'herencias'],
        }
    }

  end
end
