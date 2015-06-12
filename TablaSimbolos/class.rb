=begin

	@title	Clases para las producciones del parser de Lanscii

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description Declaración de clases (árboles) para las producciones del parser

=end
require './simboltable'
$t=SymbolTable.new

# Funcion para imprimir pipes.
def print_pipe(pipe)
	for i in 1..pipe
		print "|  "
	end
end

# Símbolo inicial con declaraciones de variables
class PROGRAM_DECLARE_BODY
	def initialize(val1,val2)
		@declare = val1
		@body = val2
		@table = $t
	end

	def check

	end

	def to_s(pipe)
		@body.to_s(pipe)
	end
end

# Símbolo inicial sin declaraciones de variables
class PROGRAM_BODY
	def initialize(val1)
		@body = val1
		@table = $t
	end

	def check()
	end

	def to_s(pipe)
		@body.to_s(pipe)
	end
end

# Declaración de enteros
class DECLARE_INT
	def initialize(val)
		@inst = val
		$t.insert(val.get_id,:INT)
	end
end

# Declaración de booleanos
class DECLARE_BOOL
	def initialize(val)
		@inst = val
		$t.insert(val.get_id,:BOOL)

	end
end

# Declaración de lienzos
class DECLARE_LIE
	def initialize(val)
		@inst = val
		$t.insert(val.get_id,:CANV)
	end
end

# Más identificadores dentro de una declaración
class MORE_IDENTS
	def initialize(val1,val2)
		@id = val1
		@next_inst = val2
	end
	def get_id
		return @id
	end
end

# Otra declaración de variable
class IDENTS_DECLARE
	def initialize(val1,val2)
		@id = val1
		@declare = val2
	end
	def get_id
		return @id
	end
end

# Única declaración de variable
class IDENTS_ID
	def initialize(val1)
		@id = val1
	end
	def get_id
		return @id
	end
end

# Asignación
class BODY_ASSIGN

	def initialize(val1,val2)
		@id = val1
		@exp = val2
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "ASSIGN:"
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "VARIABLE:"
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe-1
		puts "IDENTIFIER: " + @id.to_s
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "EXPRESSION:"
		@exp.to_s(pipe)
	end
end

# Otro cuerpo
class BODY
	def initialize(val1)
		@body = val1
	end

	def to_s(pipe)
		@body.to_s(pipe)
	end
end

# Read
class BODY_READ
	def initialize(val1)
		@id = val1
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts 'READ:'
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts 'VARIABLE:'
		for i in 1..pipe
			print "|  "
		end
		puts 'IDENTIFIER: ' + @id.to_s
	end
end

# Write
class BODY_WRITE
	def initialize(val1)
		@expr = val1
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts 'WRITE:'
		@expr.to_s(pipe)
	end
end

# Secuenciación
class BODIES
	def initialize(val1,val2)
		@body1 = val1
		@body2 = val2
	end
	def to_s(pipe)
		@body1.to_s(pipe)
		@body2.to_s(pipe)
	end
end

# Condicional simple
class IF_THEN
	def initialize(val1,val2)
		@exp = val1
		@body = val2
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "CONDITIONAL STATEMENT:"
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "CONDITION:"
		@exp.to_s(pipe)
		for i in 1..pipe-1
			print "|  "
		end
		puts "THEN:"
		@body.to_s(pipe)
	end
end

# Condicional doble
class IF_THEN_ELSE
	def initialize(val1,val2,val3)
		@exp = val1
		@body1 = val2
		@body2 = val3
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "CONDITIONAL STATEMENT:"
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "CONDITION:"
		@exp.to_s(pipe)
		for i in 1..pipe-1
			print "|  "
		end
		puts "THEN:"
		@body1.to_s(pipe)
		for i in 1..pipe-1
			print "|  "
		end
		puts "ELSE:"
		@body2.to_s(pipe)
	end
end

# Expresión
class EXP
	def initialize(val)
		@exp = val
	end
	def to_s(pipe)
		@exp.to_s(pipe)
	end
end

# Identificador de variable
class EXP_ID
	def initialize(val)
		@id = val
	end
	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		puts 'IDENTIFIER: ' + @id.to_s
	end
end 

# Constante numérica
class EXP_NUM
	def initialize(val)	
		@value = val
	end
	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		puts 'NUMBER: '+@value.to_s
	end
end

# Expresión booleana
class EXP_BOOL
	def initialize(val)	
		@value = val
	end
	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		puts 'BOOLEAN: ' + @value.to_s
	end
end

# Expresiones binarias
class DOUBLE_EXP
	def initialize(val1,val2,val3)	
		@expr1 = val1
		@expr2 = val3
		@oper = val2
	end
	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts 'OPERATION: ' + @oper.to_s
		@expr1.to_s(pipe)
		@expr2.to_s(pipe)
	end
end

# Expresiones unarias con subexpresión a la izquierda (operador a la derecha)
class LEFT_EXP
	def initialize(val1,val2)	
		@expr = val1
		@oper = val2
	end
	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts 'OPERATION: '+@oper.to_s
		@expr.to_s(pipe)
	end
end

# Expresiones unarias con subexpresión a la derecha (operador a la izquierda)
class RIGHT_EXP
	def initialize(val1,val2)	
		@expr = val2
		@oper = val1
	end
	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts 'OPERATION: '+@oper.to_s
		@expr.to_s(pipe)
	end
end

# Iteración con una expresión
class ONE_COND_ITER
	def initialize(val1,val2)
		@expr = val1
		@body = val2
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "ITERATION STATEMENT:"
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "CONDITION:" 
		@expr.to_s(pipe)
		for i in 1..pipe-1
			print "|  "
		end
		puts "THEN:"
		@body.to_s(pipe)
	end
end

# Iteración con dos expresiones
class ITER
	def initialize(val1,val2,val3)
		@expr1 = val1
		@expr2 = val2
		@body = val3
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "ITERATION STATEMENT:"
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "LOWER LIMIT:"
		@expr1.to_s(pipe)
		for i in 1..pipe-1
			print "|  "
		end
		puts "UPPER LIMIT:" 
		@expr2.to_s(pipe)
		for i in 1..pipe-1
			print "|  "
		end
		puts "DO:\n"
		@body.to_s(pipe)
	end
end


# Iteración con contador
class ID_ITER
	def initialize(val1,val2,val3,val4)
		@id = val1
		@expr1 = val2
		@expr2 = val3
		@body = val4
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		pipe=pipe+1
		puts "ITERATION STATEMENT:"
		for i in 1..pipe
			print "|  "
		end
		puts "IDENTIFIER:" + @id.to_s
		for i in 1..pipe
			print "|  "
		end
		puts "LOWER LIMIT:" 
		@expr1.to_s(pipe+1)
		for i in 1..pipe
			print "|  "
		end
		puts "UPPER LIMIT:"
		@expr2.to_s(pipe+1)
		for i in 1..pipe
			print "|  "
		end
		puts "DO:"
		@body.to_s(pipe+1)
	end
end

# Expresiones de tipo lienzo
class EXP_CANVAS
	def initialize(val)
		@canvas = val
	end

	def to_s(pipe)
		for i in 1..pipe
			print "|  "
		end
		puts 'CANVAS: '+@canvas.to_s
	end
end