=begin

	@title	Clases para las producciones del parser de Lanscii

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description Declaración de clases (árboles) para las producciones del parser

=end
require './symboltable'
$t=SymbolTable.new
$e=Array.new

# Funcion para imprimir pipes.
def print_pipe(pipe)
	for i in 1..pipe
		print "|  "
	end
end

# Símbolo inicial con declaraciones de variables
class PROGRAM_DECLARE_BODY
	attr_accessor :table
	def initialize(val1,val2)
		@declare = val1
		@body = val2
		@table = $t
	end

	def check
		if $t.table != {}
			@table = SymbolTable.new
			@table.father = $t
			$t = @table
		end
		if !(@declare.insertId)
			$e.push("ERROR PROGRAMA")
		end
		$t.to_s
		@body.check

		if $t.father != nil
			$t = $t.father
		else
			return $e
		end
	end

	def to_s(pipe)
		@body.to_s(pipe)
	end
end

# Símbolo inicial sin declaraciones de variables
class PROGRAM_BODY
	attr_accessor :table
	def initialize(val1)
		@body = val1
		@table = $t
	end

	def check
		if $t.table != {}
			@table = SymbolTable.new
			@table.father = $t
			$t = @table
		end
		@body.check
		if $t.father != nil
			$t = $t.father
		end	
	end

	def to_s(pipe)
		@body.to_s(pipe)
	end
end

# Declaración de enteros
class DECLARE_INT
	def initialize(val)
		@inst = val
	end

	def insertId
		@inst.insertId(:INT)
	end
end

# Declaración de booleanos
class DECLARE_BOOL
	def initialize(val)
		@inst = val
	end

	def insertId
		@inst.insertId(:BOOL)
	end
end

# Declaración de lienzos
class DECLARE_LIE
	def initialize(val)
		@inst = val
	end
	def insertId
		@inst.insertId(:CANV)
	end
end

# Más identificadores dentro de una declaración
class MORE_IDENTS
	def initialize(val1,val2)
		@id = val1
		@next_inst = val2
	end
	def insertId(type)
		if !($t.insert(@id,type))
			$e.push("ERROR DECLARANDO")
		end
		@next_inst.insertId(type)

	end
end

# Otra declaración de variable
class IDENTS_DECLARE
	def initialize(val1,val2)
		@id = val1
		@declare = val2
	end
	def insertId(type)
		if !($t.insert(@id,type))
			$e.push("ERROR DECLARANDO")
		end
		@declare.insertId()

	end
end

# Única declaración de variable
class IDENTS_ID
	def initialize(val1)
		@id = val1
	end
	def insertId(type)
		$t.insert(@id,type)

	end
end

# Asignación
class BODY_ASSIGN

	def initialize(val1,val2)
		@id = val1
		@exp = val2
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts "ASSIGN:"
		print_pipe(pipe)
		pipe+=1
		puts "VARIABLE:"
		print_pipe(pipe)
		pipe-=1
		puts "IDENTIFIER: " + @id.to_s
		print_pipe(pipe)
		pipe+=1
		puts "EXPRESSION:"
		@exp.to_s(pipe)
	end

	def check
		if $t.lookup("1"+@id)==:CONT
			puts "ERROR CONTADOR"
		end
		tmp=$t.lookup(@id)		
		tmp2=@exp.get_type
		if tmp2!=nil
			if tmp!=tmp2
				$e.push("ERROR ASIGNACION")
			end
		end
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

	def check
		@body.check
	end
end

# Read
class BODY_READ
	def initialize(val1)
		@id = val1
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'READ:'
		print_pipe(pipe)
		pipe+=1
		puts 'VARIABLE:'
		print_pipe(pipe)
		puts 'IDENTIFIER: ' + @id.to_s
	end
	def check
		if $t.lookup("1"+@id)==:CONT
			puts "ERROR CONTADOR"
		end
		if $t.lookup(@id)==nil
			$e.push("ERROR READ")
		end
	end
end

# Write
class BODY_WRITE
	def initialize(val1)
		@expr = val1
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'WRITE:'
		@expr.to_s(pipe)
	end
	def check
		if @expr.get_type!=:CANV
			$e.push("ERROR WRITE")
		end
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
	def check
		@body1.check
		@body2.check
	end
end

# Condicional simple
class IF_THEN
	def initialize(val1,val2)
		@exp = val1
		@body = val2
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts "CONDITIONAL STATEMENT:"
		print_pipe(pipe)
		pipe+=1
		puts "CONDITION:"
		@exp.to_s(pipe)
		print_pipe(pipe-1)
		puts "THEN:"
		@body.to_s(pipe)
	end
	def check
		@body.check
		if @exp.get_type == nil
			$e.push("ERROR IF THEN")
		end
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
		print_pipe(pipe)
		pipe+=1
		puts "CONDITIONAL STATEMENT:"
		print_pipe(pipe)
		pipe+=1
		puts "CONDITION:"
		@exp.to_s(pipe)
		print_pipe(pipe-1)
		puts "THEN:"
		@body1.to_s(pipe)
		print_pipe(pipe-1)
		puts "ELSE:"
		@body2.to_s(pipe)
	end
	def check
		@body1.check
		@body2.check
		if @exp.get_type
			$e.push("ERROR IF THEN ELSE")
		end
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
	def get_type
		return @exp.get_type
	end
end

# Identificador de variable
class EXP_ID
	def initialize(val)
		@id = val
	end
	def to_s(pipe)
		print_pipe(pipe)
		puts 'IDENTIFIER: ' + @id.to_s
	end
	def get_type
		return $t.lookup(@id)
	end
end 

# Constante numérica
class EXP_NUM
	def initialize(val)	
		@value = val
		@type = :INT
	end
	def to_s(pipe)
		print_pipe(pipe)
		puts 'NUMBER: '+@value.to_s
	end
	def get_type
		return @type
	end
end

# Expresión booleana
class EXP_BOOL
	def initialize(val)	
		@value = val
		@type = :BOOL
	end
	def to_s(pipe)
		print_pipe(pipe)
		puts 'BOOLEAN: ' + @value.to_s
	end
	def get_type
		return @type
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
		print_pipe(pipe)
		pipe+=1
		puts 'OPERATION: ' + @oper.to_s
		@expr1.to_s(pipe)
		@expr2.to_s(pipe)
	end
	def get_type
		tmp=@expr1.get_type
		tmp2=@expr2.get_type
		if @oper.match(/\+|\-|\*|\/|%/)

			if (tmp==:INT && tmp2==:INT)
				return :INT
			else
				$e.push("ERROR EXP")
				return nil
			end
		elsif @oper.match(/\/\\|\\\/|\^/)
			if (tmp==:BOOL && tmp2==:BOOL)
				return :BOOL
			else
				$e.push("ERROR EXP")
				return nil
			end
		elsif @oper.match(/&|~/)
			if (tmp==:CANV && tmp2==:CANV)
				return :CANV
			else
				$e.push("ERROR EXP")
				return nil
			end
		elsif @oper.match(/<=|>=|<|>/)
			if (tmp==:INT && tmp2==:INT)
				return :BOOL
			else
				$e.push("ERROR EXP")
				return nil
			end
		elsif @oper.match(/\=|\/=/)
			if (tmp==:INT && tmp2==:INT) || (tmp==:BOOL && tmp2==:BOOL) || (tmp==:CANV && tmp2==:CANV)
				return :BOOL
			else
				$e.push("ERROR EXP")
				return nil
			end
		end
	end
end

# Expresiones unarias con subexpresión a la izquierda (operador a la derecha) Not Apostrophe
class LEFT_EXP
	def initialize(val1,val2)	
		@expr = val1
		@oper = val2
	end
	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'OPERATION: '+@oper.to_s
		@expr.to_s(pipe)
	end
	def get_type
		tmp=@expr.get_type
		if @oper.match(/\^/)
			if (tmp==:BOOL)
				return :BOOL
			else
				$e.push("ERROR EXP")
				return nil
			end
		elsif @oper.match(/'/)
			if (tmp==:CANV)
				return :CANV
			else
				$e.push("ERROR EXP")
				return nil
			end
		end
	end
end

# Expresiones unarias con subexpresión a la derecha (operador a la izquierda) Minus Dollar
class RIGHT_EXP
	def initialize(val1,val2)	
		@expr = val2
		@oper = val1
	end
	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'OPERATION: '+@oper.to_s
		@expr.to_s(pipe)
	end
	def get_type
		tmp=@expr.get_type
		if @oper.match(/-/)
			if (tmp==:INT)
				return :INT
			else
				$e.push("ERROR EXP")
				return nil
			end
		elsif @oper.match(/$/)
			if (tmp==:CANV)
				return :CANV
			else
				$e.push("ERROR EXP")
				return nil
			end
		end
	end
end

# Iteración con una expresión
class ONE_COND_ITER
	def initialize(val1,val2)
		@expr = val1
		@body = val2
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts "ITERATION STATEMENT:"
		print_pipe(pipe)
		pipe+=1
		puts "CONDITION:" 
		@expr.to_s(pipe)
		print_pipe(pipe-1)
		puts "THEN:"
		@body.to_s(pipe)
	end
	def check
		@body.check
		if @expr.get_type!=:BOOL
			$e.push("ERROR ITER ONE")
		end
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
		print_pipe(pipe)
		pipe+=1
		puts "ITERATION STATEMENT:"
		print_pipe(pipe)
		pipe+=1
		puts "LOWER LIMIT:"
		@expr1.to_s(pipe)
		print_pipe(pipe-1)
		puts "UPPER LIMIT:" 
		@expr2.to_s(pipe)
		print_pipe(pipe-1)
		puts "DO:\n"
		@body.to_s(pipe)
	end
	def check
		@body.check
		if !(@expr1.get_type==:INT && @expr2.get_type==:INT)
			$e.push("ERROR ITER TWO")
		end
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
		print_pipe(pipe)
		pipe+=1
		puts "ITERATION STATEMENT:"
		print_pipe(pipe)
		puts "IDENTIFIER:" + @id.to_s
		print_pipe(pipe)
		puts "LOWER LIMIT:" 
		@expr1.to_s(pipe+1)
		print_pipe(pipe)
		puts "UPPER LIMIT:"
		@expr2.to_s(pipe+1)
		print_pipe(pipe)
		puts "DO:"
		@body.to_s(pipe+1)
	end
	def check
		if !(@expr1.get_type==:INT && @expr2.get_type==:INT)
			$e.push("ERROR ITER ID")
		end
		if $t.lookup("1"+@id)==:CONT
			puts "ERROR CONTADOR"
		end
		puts "Estoy aqui"
		$t.insert("1"+@id,:CONT)
		@body.check
		$t.delete("1"+@id)	
	end
end

# Expresiones de tipo lienzo
class EXP_CANVAS
	def initialize(val)
		@canvas = val
		@type = :CANV
	end

	def to_s(pipe)
		print_pipe(pipe)
		puts 'CANVAS: '+@canvas.to_s
	end
	def get_type
		return @type
	end
end