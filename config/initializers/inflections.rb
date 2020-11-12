# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
	inflect.plural 'institucion', 'instituciones'
	inflect.plural 'Institucion', 'Instituciones'
	inflect.singular 'instituciones', 'institucion'
	inflect.singular 'Instituciones', 'Institucion'

	inflect.plural 'investigador', 'investigadores'
	inflect.plural 'Investigador', 'Investigadores'
	inflect.singular 'investigadores', 'investigador'
	inflect.singular 'Investigadores', 'Investigador'

	inflect.plural 'publicacion', 'publicaciones'
	inflect.plural 'Publicacion', 'Publicaciones'
	inflect.singular 'publicaciones', 'publicacion'
	inflect.singular 'Publicaciones', 'Publicacion'

	inflect.plural 'autor', 'autores'
	inflect.plural 'Autor', 'Autores'
	inflect.singular 'autores', 'autor'
	inflect.singular 'Autores', 'Autor'

	inflect.plural 'origen', 'origenes'
	inflect.plural 'Origen', 'Origenes'
	inflect.singular 'origenes', 'origen'
	inflect.singular 'Origenes', 'Origen'

	inflect.plural 'agregacion', 'agregaciones'
	inflect.plural 'Agregacion', 'Agregaciones'
	inflect.singular 'agregaciones', 'agregacion'
	inflect.singular 'Agregaciones', 'Agregacion'

	inflect.plural 'referencia', 'referencias'
	inflect.plural 'Referencia', 'Referencias'

	inflect.plural 'metodologia', 'metodologias'
	inflect.plural 'Metodologia', 'Metodologias'

	inflect.plural 'revista', 'revistas'
	inflect.plural 'Revista', 'Revistas'

end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
