module PublicacionesHelper
	def procesa_autores(detalle_autores)
		st = 0
		resultado = []
		nombre = ''
		llave = []
		ant = ''
		detalle_autores.strip.split('').each do |c|
			case st
			when 0 # INICIO
				if c.match(/[a-z1-9]/) # llave?
					llave << c
					st = 1 
				elsif c.match(/[A-Z]/) # inicio nombre?
					nombre = c
					st = 3
				else # FATAL
					st = 100
				end
			when 1 # LLAVE
				if c.match(/\s/) # fin llave?
					st = 2
				elsif c.match(/,/) # otra llave
					st = 0
				else # FATAL
					st = 100
				end
			when 2 # FIN LLgAVE?
				if c.match(/\s/) # consume espacios
				elsif c.match(/,/) # otra llave
					st = 0
				elsif c.match(/[A-Z]/) # Inicio Nombre
					nombre = c
					st = 3
				else # FATAL
					st = 100
				end
			when 3 # NOMBRE
				if c.match(/[a-zA-Z]/) # completa nombre
					nombre += c
				elsif c.match(/\s/) # fin nombre
					nombre += c
					st = 4
				else # FATAL
					st = 100
				end
			when 4 # FIN NOMBRE
				if c.match(/\s/) # consume espacios
				elsif c.match(/[A-Z]/) # inicio Inicial/Apellido?
					nombre += c
					st = 5
				elsif c.match(/[a-z]/) # apellido
					nombre += c
					st = 10
				else # FATAL
					st = 100
				end
			when 5 # INICIO INICIAL/APELLIDO
				if c.match(/\./) #/ inicial
					nombre += c
					st = 6
				elsif c.match(/\s/) # fin Inicial (AGREGAR A AUTOMATA)
					nombre += c
					st = 8
				elsif c.match(/[a-zA-Z]/) # Apellido
					nombre += c
					st = 10
				else # FATAL
					st = 100
				end
			when 6 # . INICIAL
				if c.match(/[A-Z]/) # Inicial
					nombre += c
					st = 7
				elsif c.match(/\s/) # fin Inicial
					nombre += c
					st = 8
				else # FATAL
					st = 100
				end
			when 7 # INICIAL
				if c.match(/\./) # . Inicial
					nombre += c
					st = 6
				elsif c.match(/\s/) # fin Inicial
					nombre += c
					st = 8
				else # FATAL
					st = 100
				end
			when 8 # FIN INICIAL
				if c.match(/\s/) # consume espacios
				elsif c.match(/[a-zA-Z]/) # Inicio Apellido
					nombre += c
					st = 10
				else # FATAL
					st = 100
				end
			when 10 # APELLIDO
				if c.match(/[a-zA-Z]/) # completa apellido
					nombre += c
				elsif c.match(/[1-9]/) # llave
					llave << c
					st = 11
				elsif c.match(/\s/) # fin apellido?
					# nombre += c					
					st = 15
				elsif c.match(/a/) # a de 'and' (AGREGAR A AUTOMATA)
					st = 16
				else # FATAL
					st = 100
				end
			when 11 # LLAVE
				if c.match(/\s/) # fin llave?
					st = 12
				elsif c.match(/,/) # fin nombre?
					st = 13
				else # FATAL
					st = 100
				end
			when 12 # FIN LLAVE?
				if c.match(/\s/) # ahi mismo
				elsif c.match(/,/) # fin nombre?
					st = 13
				elsif c.match(/a/) # a de 'and'
					st = 16
				elsif c.match(/&/) # fin de palabra
					resultado << [nombre, llave]
					nombre = c
					llave = []
					st = 19
				else # FATAL
					st = 100
				end
			when 13 # FIN NOMBRE?
				if c.match(/[,\s]/) # consume espacios (COMPLETAR AUTOMATA)
				elsif c.match(/[a-z1-9\*]/) or c.ord == 8727 # llave (COMPLETAR AUTOMATA)
					llave << c
					st = 11 
				elsif c.match(/[A-Z]/) # Inicio Nombre
					resultado << [nombre, llave]
					nombre = c
					llave = []
					st = 3
				else # FATAL
					st = 100
				end
			when 15 # FIN APELLIDO
				if c.match(/\s/) # consume espacios
				elsif c.match(/[1-9]/) # key
					llave << c
					st = 11
				elsif c.match(/a/) # a letra de 'and'???
					st = 16
				elsif c.match(/[b-z]/) # llave/apellido?
					ant = c
					st = 20
				elsif c.match(/[A-Z]/) # Sigue el apellido (COMPLETAR AUTOMATA)
					nombre += ' '+c
					st = 10
				elsif c.match(/[,&]/) # Fin Nombre
					resultado << [nombre, llave]
					nombre = ''
					llave = []
					st = 19
				else # FATAL
					st = 100
				end
			when 16 # 'a' DE 'and'/LLAVE/APELLIDO
				if c.match(/\s/) # fin llave
					llave << 'a'
					st = 12
				elsif c.match(/,/) # Fin Nombre?
					llave << 'a'
					st = 13
				elsif c.match(/[a-mo-z]/) # apellido
					nombre += 'a'+c
					st = 10
				elsif c.match(/n/) # n de 'and'
					st = 17
				else # FATAL
					st = 100
				end
			when 17 # 'n' DE 'and'/APELLIDO?
				if c.match(/d/) # d de 'and'
					st = 18
				elsif c.match(/[a-ce-z]/) # apellido
					nombre += 'an'+c
					st = 10
				else # FATAL
					st = 100
				end
			when 18 # 'd' DE 'and'/ APELLIDO
				if c.match(/\s/) # fin de 'and'
					resultado << [nombre, llave]
					nombre = ''
					llave = []
					st = 19
				elsif c.match(/[a-z]/) # apellido
					nombre += 'and'+c
					st = 10
				else # FATAL
					st = 100
				end
			when 19 # FIN NOMBRE COMPLETO
				if c.match(/\s/) # se queda ahí
				elsif c.match(/[A-Z]/) # Inicio de Nombre
					nombre = c
					st = 3
				else # FATAL
					st = 100
				end
			when 20 # LLAVE/APELLIDO
				if c.match(/\s/) # llave
					llave << ant
					st = 12
				elsif c.match(/[a-z]/) # apellido
					nombre += ' '+ant+c
					st = 10
				end
			end
		end
		llave << 'a' if st == 16
		llave << ant if st == 20
		resultado << [nombre, llave]
		resultado
	end
end
