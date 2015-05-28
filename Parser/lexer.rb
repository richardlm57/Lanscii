#!/usr/bin/env ruby

=begin

	@title	Anlisis Lexicográfico del interpretador para el lenguaje Lanscii

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description Código fuente del análisis lexicográfico para el interpretador de Lanscii

=end

class IdString
	def initialize(value)
		@value=value
	end

	def to_s
		@value.to_s
	end
end

class Number
	def initialize(value)
		@value=value
	end

	def to_s
		@value.to_s
	end
end

class Canvas
	def initialize(value)
		@value=value
	end

	def to_s
		@value.to_s
	end
end

class Symbol
	def initialize(value)
		@value=value
	end

	def to_s
		@value.to_s
	end
end


class Lexer
	def lexing(f)

		# Lectura del contenido del archivo de entrada

		name = f
		file = File.open(name,"r")
		content = file.read
		file.close

		# Diccionario de tokens con su identificador

		strings_dic = {"{"=>"LCURLY","}"=>"RCURLY","|"=>"PIPE","%"=>"PERCENTAGE","!"=>"EXCLAMATIONMARK",
						"@"=>"AT","</>"=>"CANVAS","<\\>"=>"CANVAS","<|>"=>"CANVAS",
						"<_>"=>"CANVAS","<->"=>"CANVAS","="=>"EQUALS",".."=>"DOUBLEDOT",","=>"COMMA",";"=>"SEMICOLON",
						"read"=>"READ","write"=>"WRITE","?"=>"QUESTIONMARK","&"=>"AMPERSAND","~"=>"TILDE"
						":"=>"COLON","("=>"LPARENTHESIS",")"=>"RPARENTHESIS", "["=>"LSQUARE", "]"=>"RSQUARE",
						"+"=>"PLUS","-"=>"MINUS","*"=>"TIMES","/"=>"DIVIDE",
						"\/\\"=>"AND","\\\/"=>"OR","^"=>"NOT","<"=>"LESS","<="=>"LESSEQUAL",
						">"=>"GREATER",">="=>"GREATEREQUAL",
						"\/="=>"NOTEQUAL","#"=>"EMPTYCANVAS","$"=>"DOLLAR","'"=>"APOSTROPHE","true"=>"TRUE",
						"false"=>"FALSE"}

		correct_program=Array.new	# Arreglo con los strings que se imprimirán cuando un programa es correcto
		incorrect_program=Array.new	# Arreglo con los strings que se imprimirán cuando un programa es incorrecto
		incorrect=false # Determina si un programa es incorrecto
		comment=false 	# Determina si se está dentro de un comentario
		commentR=0		# Línea del inicio de comentario
		commentC=0		# Columna del inicio de comentario
		varMatch=/\{-|-\}|\/=|<\/>|<\\>|<\|>|<_>|<->|<\ >|\/\\|\\\/|<=|>=|\.\.|
				|([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*|[0-9]+|
				|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\+|-|\*|\/|\^|<|>|\[|\]|&|~|
				|#|,|\$|'|true|false/ 	# Expresión regular para reconocer las palabras reservadas de LANSCII
		i=1		# Contador de línea

		content.each_line do |x|	# Se itera por las líneas del archivo reconociendo símbolos (o errores)
			j=0		# Contador de columna
			s=x.split
			s.each do |t| # Se itera por el split de la línea para matchear con la regex del lenguaje
				while x[j]!=t[0] do
					j+=1
				end
				m=t.match(varMatch) 	# Match con la regex del lenguaje

				if !comment 
					if m == nil	# Se verifican símbolos incorrectos si no está dentro de un comentario
						incorrect = true
						for k in 0..(t.size-1)
							incorrect_program.push("Error: Unexpected character: \""+t[k]+"\" at line: "+i.to_s+", column: "+(j+1+k).to_s)
						end
						j+=1
					else
						if (n=m.pre_match.match(varMatch) == nil) && (m.pre_match != "")
							incorrect= true
							for k in 0..((m.pre_match).size-1)
								incorrect_program.push("Error: Unexpected character: \""+m.pre_match[k]+"\" at line: "+i.to_s+", column: "+(j+1+k).to_s)
							end
						end
					end
				end
				while m do 	# Se itera por el resultado del match hecho para una posición del split de la línea buscando los símbolos del lenguaje,
							# si no se está dentro de un comentrario
					if !comment 	
						if m[0] =~ /\{-/
							comment=true
							commentR=i
							commentC=j+1
							j+=m[0].size

						elsif m[0] =~ /-}/
							correct_program.push("token "+strings_dic[m[0][0]]+" value ("+m[0][0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
							j+=1
							correct_program.push("token "+strings_dic[m[0][1]]+" value ("+m[0][1]+") at line: "+i.to_s+", column: "+(j+1).to_s)
							j+=1

						elsif m[0] =~ /<\/>|<\\>|<\|>|<_>|<->|<\ >/
							correct_program.push("token "+strings_dic[m[0]]+" value ("+m[0][1]+") at line: "+i.to_s+", column: "+(j+1).to_s)
							j+=m[0].size

						elsif m[0] =~ /\/=|\/\\|\\\/|<=|>=|\.\.|<|>|\{|\}|\||%|!|@|=|;|read|write|\?|:|\(|\)|\[|\]|&|~|
							|\+|\-|\*|\/|\^|#|,|\$|'|true|false/
							correct_program.push("token "+strings_dic[m[0]]+" value ("+m[0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
							j+=m[0].size

						elsif m[0] =~ /([A-Z]|[a-z]|_)([A-Z]|[a-z]|_|[0-9])*/
							correct_program.push("token IDENTIFIER value ("+m[0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
							j+=m[0].size

						elsif m[0] =~ /[0-9]+/
							correct_program.push("token NUMBER value ("+m[0]+") at line: "+i.to_s+", column: "+(j+1).to_s)
							j+=m[0].size

						end
					else
						if m[0] =~ /-}/
							comment=false
						end
						j+=m[0].size
					end
					
					temp=m.post_match	# Se obtienen los caracteres después del match hecho
					m=temp.match(varMatch)
					if !comment
						if m == nil # Se verifican símbolos incorrectos dentro de una posición del split si no está dentro de un comentario
							if temp != ""
								incorrect = true
								for k in 0..(temp.size-1)
									incorrect_program.push("Error: Unexpected character: \""+temp[k]+"\" at line: "+i.to_s+", column: "+(j+1+k).to_s)
								end
								j+=1
							end
						else
							if (n=m.pre_match.match(varMatch) == nil) && (m.pre_match != "")
								incorrect= true
								for k in 0..((m.pre_match).size-1)
									incorrect_program.push("Error: Unexpected character: \""+m.pre_match[k]+"\" at line: "+i.to_s+", column: "+(j+1+k).to_s)
								end
							end
						end
					end
				end
			end
			i+=1	
		end
		if comment 	# Error si hubo un comentario abierto que nunca fue cerrado
			puts "Error: Comment section opened but not closed at line: "+commentR.to_s+", column: "+commentC.to_s 
		else
			if incorrect 	# Si el programa es incorrecto, sólo se imprimen los errores del programa
				puts incorrect_program	
			else			# Si el programa es correcto, se imprimen los símbolos reconocidos
				puts correct_program	
			end
		end
	end
end