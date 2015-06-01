=begin

	@title	Clases para las producciones del parser de Lanscii

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description Declaración de clases (árboles) para las producciones del parser

=end

# Símbolo inicial con declaraciones de variables
class PROGRAM_DECLARE_BODY
	def initialize(val1,val2)
		@declare = val1
		@body = val2
	end

	def to_s
		@body.to_s
	end
end

# Símbolo inicial sin declaraciones de variables
class PROGRAM_BODY
	def initialize(val1)
		@body = val1
	end

	def to_s
		@body.to_s
	end
end

# Declaración de enteros
class DECLARE_INT
	def initialize(val)
		@inst = val
	end
end

# Declaración de booleanos
class DECLARE_BOOL
	def initialize(val)
		@inst = val
	end
end

# Declaración de lienzos
class DECLARE_LIE
	def initialize(val)
		@inst = val
	end
end

# Más identificadores dentro de una declaración
class MORE_INST
	def initialize(val1,val2)
		@id = val1
		@next_inst = val2
	end
end

# Otra declaración de variable
class INST_DECLARE
	def initialize(val1,val2)
		@id = val1
		@declare = val2
	end
end

# Única declaración de variable
class INST_ID
	def initialize(val1)
		@id = val1
	end
end

# Asignación
class BODY_ASSIGN

	def initialize(val1,val2)
		@id = val1
		@exp = val2
	end

	def to_s
		puts 'ASSIGN:'
		puts '|  VARIABLE:'
		puts '|  | 	  IDENTIFIER: ' + @id 
		puts '|  EXPRESSION:'
		puts '|  |        '+ @exp.to_s
	end
end

# Otro cuerpo
class BODY
	def initialize(val1)
		@body = val1
	end

	def to_s
		@body.to_s
	end
end

# Read
class BODY_READ
	def initialize(val1)
		@id = val1
	end

	def to_s
		puts 'READ:'
		puts '|  VARIABLE:'
		puts '|  | 	  IDENTIFIER: ' + @id
	end
end

# Write
class BODY_WRITE
	def initialize(val1)
		@id = val1
	end

	def to_s
		puts 'WRITE:'
		puts @id.to_s
	end
end

# Secuenciación
class BODIES
	def initialize(val1,val2)
		@body1 = val1
		@body2 = val2
	end
	def to_s
		@body1.to_s
		@body2.to_s
	end
end

# Condicional simple
class IF_THEN
	def initialize(val1,val2)
		@exp = val1
		@body = val2
	end

	def to_s
		puts "CONDITIONAL STATEMENT:\n" + "|  CONDITION:\n" + @exp.to_s
		puts "| THEN:\n"
		@body.to_s
	end
end

# Condicional doble
class IF_THEN_ELSE
	def initialize(val1,val2,val3)
		@exp = val1
		@body1 = val2
		@body2 = val3
	end

	def to_s
		puts "CONDITIONAL STATEMENT:\n" + "|  CONDITION:\n" + @exp.to_s
		puts "| THEN:\n"
		@body1.to_s
		puts "| ELSE:\n"
		@body2.to_s
	end
end

# Expresión
class EXP
	def initialize(val)
		@exp = val
	end
	def to_s
		return @exp.to_s
	end
end

# Identificador de variable
class EXP_ID
	def initialize(val)
		@id = val
	end
	def to_s
		return 'IDENTIFIER: ' + @id.to_s
	end
end

# Constante numérica
class EXP_NUM
	def initialize(val)	
		@value = val
	end
	def to_s
		return 'NUMBER: '+@value.to_s
	end
end

# Expresión booleana
class EXP_BOOL
	def initialize(val)	
		@value = val
	end
	def to_s
		return 'BOOLEAN: '+@value.to_s
	end
end

# Expresiones binarias
class DOUBLE_EXP
	def initialize(val1,val2,val3)	
		@expr1 = val1
		@expr2 = val3
		@oper = val2
	end
	def to_s
		return 'OPERATION: '+@oper.to_s+"\n"+"|  "+@expr1.to_s+"\n"+"|  "+@expr2.to_s+"\n"
	end
end

# Expresiones unarias con subexpresión a la izquierda (operador a la derecha)
class LEFT_EXP
	def initialize(val1,val2)	
		@expr = val1
		@oper = val2
	end
	def to_s
		return 'OPERATION: '+@oper.to_s+"\n"+"|  "+@expr.to_s+"\n"
	end
end

# Expresiones unarias con subexpresión a la derecha (operador a la izquierda)
class RIGHT_EXP
	def initialize(val1,val2)	
		@expr = val2
		@oper = val1
	end
	def to_s
		return 'OPERATION: '+@oper.to_s+"\n"+"|  "+@expr.to_s+"\n"
	end
end

# Iteración con una expresión
class ONE_COND
	def initialize(val1,val2)
		@expr = val1
		@body = val2
	end

	def to_s
		puts "ITERATION STATEMENT:\n" + "|  CONDITION:\n" + @expr.to_s
		puts "| THEN:\n"
		@body.to_s
	end
end

# Iteración con dos expresiones
class COND
	def initialize(val1,val2,val3)
		@expr1 = val1
		@expr2 = val2
		@body = val3
	end

	def to_s
		puts "ITERATION STATEMENT:\n" + "|  LOWER LIMIT:\n" + @expr1.to_s
		puts "|  UPPER LIMIT:\n" + @expr2.to_s
		puts "| DO:\n"
		@body.to_s
	end
end

# Iteración con contador
class ID_COND
	def initialize(val1,val2,val3,val4)
		@id = val1
		@expr1 = val2
		@expr2 = val3
		@body = val4
	end

	def to_s
		puts "ITERATION STATEMENT:\n" + "|  IDENTIFIER:\n" + @id.to_s
		puts "|  LOWER LIMIT:\n" + @expr1.to_s
		puts "|  UPPER LIMIT:\n" + @expr2.to_s
		puts "| DO:\n"
		@body.to_s
	end
end

# Expresiones de tipo lienzo
class EXP_CANVAS
	def initialize(val)
		@canvas = val
	end

	def to_s
		return 'CANVAS: '+@canvas.to_s
	end
end