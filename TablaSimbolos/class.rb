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

# Función para imprimir errores de tipo
def print_error(oper,type)
	if type == :INT
		return "Line: "+oper[1].to_s+", Column: "+oper[2].to_s+" operator '"+oper[0].to_s+"' doesn't work with types '@' and '!'"
	elsif type == :CANV
		return "Line: "+oper[1].to_s+", Column: "+oper[2].to_s+" operator '"+oper[0].to_s+"' doesn't work with types '%' and '!'"
	else
		return "Line: "+oper[1].to_s+", Column: "+oper[2].to_s+" operator '"+oper[0].to_s+"' doesn't work with types '%' and '@'"
	end
end

# Símbolo inicial con declaraciones de variables
class PROGRAM_DECLARE_BODY
	attr_accessor :table
	def initialize(curly,val1,val2)
		@curly = curly
		@declare = val1
		@body = val2
		@table = $t
	end

	#Chequeo de tipos
	def check
		if $t.table != {}
			@table = SymbolTable.new
			@table.father = $t
			$t = @table
		end
		@declare.insertId
		print "In line "+@curly[1].to_s+", column "+@curly[2].to_s+": "
		$t.to_s
		puts ""
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

	#Chequeo de tipos
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

	# Función para insertar variables en la tabla de símbolos
	def insertId
		@inst.insertId(:INT)
	end
end

# Declaración de booleanos
class DECLARE_BOOL
	def initialize(val)
		@inst = val
	end

	# Función para insertar variables en la tabla de símbolos
	def insertId
		@inst.insertId(:BOOL)
	end
end

# Declaración de lienzos
class DECLARE_LIE
	def initialize(val)
		@inst = val
	end

	# Función para insertar variables en la tabla de símbolos
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

	# Función para insertar variables en la tabla de símbolos
	def insertId(type)
		if !($t.insert(@id[0],type))
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+", '"+@id[0].to_s+"' is already declared")
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

	# Función para insertar variables en la tabla de símbolos
	def insertId(type)
		if !($t.insert(@id[0],type))
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+", '"+@id[0].to_s+"' is already declared")
		end
		@declare.insertId()

	end
end

# Única declaración de variable
class IDENTS_ID
	def initialize(val1)
		@id = val1
	end

	# Función para insertar variables en la tabla de símbolos
	def insertId(type)
		$t.insert(@id[0],type)

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
		puts "IDENTIFIER: " + @id[0].to_s
		print_pipe(pipe)
		pipe+=1
		puts "EXPRESSION:"
		@exp.to_s(pipe)
	end

	#Chequeo de tipos
	def check
		if $t.lookup("1"+@id[0])==:CONT
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible modify a counter, '"+@id[0].to_s+"' is a counter")
		end
		tmp=$t.lookup(@id[0])
		if tmp == nil
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" in assignment, '"+@id[0].to_s+"' is not declared")
		else
			tmp2=@exp.get_type
			if tmp2!=nil
				if tmp!=tmp2
					$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" in assignment, '"+tmp.to_s+"' type is incompatible with '"+tmp2.to_s+"'")
				end
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

	#Chequeo de tipos
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
		puts 'IDENTIFIER: ' + @id[0].to_s
	end

	#Chequeo de tipos
	def check
		if $t.lookup("1"+@id[0])==:CONT
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible modify a counter, '"+@id[0].to_s+"' is a counter")
		elsif $t.lookup(@id[0])==nil
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" in read instruction, '"+@id[0].to_s+"' is not declared")
		end
	end
end

# Write
class BODY_WRITE
	def initialize(write,val1)
		@oper = write
		@expr = val1
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'WRITE:'
		@expr.to_s(pipe)
	end

	#Chequeo de tipos
	def check
		t=@expr.get_type
		if t!=:CANV
				if t == :BOOL
					$e.push("Line: "+@oper[1].to_s+", Column: "+@oper[2].to_s+" write instruction expects type '@' but gets '!'")
				elsif t == :INT
					$e.push("Line: "+@oper[1].to_s+", Column: "+@oper[2].to_s+" write instruction expects type '@' but gets '%'")
				elsif t == false
					$e.push("Line: "+@oper[1].to_s+", Column: "+@oper[2].to_s+" '"+@expr.id[0].to_s+"' is not declared")
				end
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

	#Chequeo de tipos
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

	#Chequeo de tipos
	def check
		@body.check
		t=@exp.get_type
		if t != :BOOL
			if t == :INT
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '%'")
			elsif t == :CANV
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '@'")
			elsif t == false
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" '"+@exp.id[0].to_s+"' is not declared")	
			end
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

	#Chequeo de tipos
	def check
		@body1.check
		@body2.check
		t=@exp.get_type
		if t != :BOOL
			if t == :INT
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '%'")
			elsif t == :CANV
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '@'")
			elsif t == false
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" '"+@exp.id[0].to_s+"' is not declared")	
			end
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

	# Función para obtener el tipo de la expresión
	def get_type
		return @exp.get_type
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @exp.get_oper
	end
end

# Identificador de variable
class EXP_ID
	def initialize(val)
		@id = val
	end

	def id
		return @id
	end

	def to_s(pipe)
		print_pipe(pipe)
		puts 'IDENTIFIER: ' + @id[0].to_s
	end

	# Función para obtener el tipo de la expresión
	def get_type
		t=$t.lookup(@id[0])
		if  t != nil
			return $t.lookup(@id[0])
		else
			return false
		end
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @id
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
		puts 'NUMBER: '+@value[0].to_s
	end

	# Función para obtener el tipo de la expresión
	def get_type
		return @type
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @value
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
		puts 'BOOLEAN: ' + @value[0].to_s
	end

	# Función para obtener el tipo de la expresión
	def get_type
		return @type
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @value
	end
end

# Expresiones binarias
class DOUBLE_EXP
	def initialize(val1,val2,val3)	
		@expr1 = val1
		@expr2 = val3
		@oper = val2
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @oper
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'OPERATION: ' + @oper[0].to_s
		@expr1.to_s(pipe)
		@expr2.to_s(pipe)
	end

	# Función para obtener el tipo de la expresión
	def get_type
		tmp=@expr1.get_type
		tmp2=@expr2.get_type
		if @oper[0].match(/\+|\-|\*|\/|%/)

			if (tmp==:INT && tmp2==:INT)
				return :INT
			else
				$e.push(print_error(@oper,:INT))
				return nil
			end
		elsif @oper[0].match(/\/\\|\\\/|\^/)
			if (tmp==:BOOL && tmp2==:BOOL)
				return :BOOL
			else
				$e.push(print_error(@oper,:BOOL))
				return nil
			end
		elsif @oper[0].match(/&|~/)
			if (tmp==:CANV && tmp2==:CANV)
				return :CANV
			else
				$e.push(print_error(@oper,:CANV))
				return nil
			end
		elsif @oper[0].match(/<=|>=|<|>/)
			if (tmp==:INT && tmp2==:INT)
				return :BOOL
			else
				$e.push(print_error(@oper,:INT))
			end
		elsif @oper[0].match(/\=|\/=/)
			if (tmp==:INT && tmp2==:INT) || (tmp==:BOOL && tmp2==:BOOL) || (tmp==:CANV && tmp2==:CANV)
				return :BOOL
			else
				$e.push("Line: "+oper[1].to_s+", Column: "+oper[2].to_s+" in assignment, type '"+tmp.to_s+"' incompatible with '"+tmp2.to_s+"'")
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
		puts 'OPERATION: '+@oper[0].to_s
		@expr.to_s(pipe)
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @oper
	end

	# Función para obtener el tipo de la expresión
	def get_type
		tmp=@expr.get_type
		if @oper[0].match(/\^/)
			if (tmp==:BOOL)
				return :BOOL
			else
				$e.push(print_error(@oper,:BOOL))
				return nil
			end
		elsif @oper[0].match(/'/)
			if (tmp==:CANV)
				return :CANV
			else
				$e.push(print_error(@oper,:CANV))
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
		puts 'OPERATION: '+@oper[0].to_s
		@expr.to_s(pipe)
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @oper
	end

	# Función para obtener el tipo de la expresión
	def get_type
		tmp=@expr.get_type
		if @oper[0].match(/-/)
			if (tmp==:INT)
				return :INT
			else
				$e.push(print_error(@oper,:INT))
				return nil
			end
		elsif @oper[0].match(/$/)
			if (tmp==:CANV)
				return :CANV
			else
				$e.push(print_error(@oper,:CANV))
				return nil
			end
		end
	end
end

# Iteración con una expresión
class ONE_COND_ITER
	def initialize(val1,val2)
		@exp = val1
		@body = val2
	end

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts "ITERATION STATEMENT:"
		print_pipe(pipe)
		pipe+=1
		puts "CONDITION:" 
		@exp.to_s(pipe)
		print_pipe(pipe-1)
		puts "THEN:"
		@body.to_s(pipe)
	end

	#Chequeo de tipos
	def check
		@body.check
		t=@exp.get_type
		if t!=:BOOL
			if t == :INT
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" iteration instruction expects type '!' but gets '%'")
			elsif t == :CANV
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" iteration instruction expects type '!' but gets '@'")
			elsif t == false
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" '"+@exp.id[0].to_s+"' is not declared")	
			end
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

	#Chequeo de tipos
	def check
		@body.check
		t1=@expr1.get_type
		t2=@expr2.get_type
		if t1!=:INT
			if t1 == :BOOL
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t1 == :CANV
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t1 == false
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" '"+@expr1.id[0].to_s+"' is not declared")	
			end
		elsif t2!=:INT
			if t2 == :BOOL
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t2 == :CANV
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t2 == false
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" '"+@expr2.id[0].to_s+"' is not declared")	
			end
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
		puts "IDENTIFIER:" + @id[0].to_s
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

	#Chequeo de tipos
	def check
		t1=@expr1.get_type
		t2=@expr2.get_type
		if t1!=:INT
			if t1 == :BOOL
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t1 == :CANV
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t1 == false
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" '"+@expr1.id[0].to_s+"' is not declared")	
			end
		elsif t2!=:INT
			if t2 == :BOOL
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t2 == :CANV
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t2 == false
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" '"+@expr2.id[0].to_s+"' is not declared")	
			end
		end
		if $t.lookup("1"+@id[0])==:CONT
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible modify a counter, '"+@id[0].to_s+"' is a counter")
		end
		$t.insert("1"+@id[0],:CONT)
		@body.check
		$t.delete("1"+@id[0])	
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
		puts 'CANVAS: '+@canvas[0].to_s
	end

	# Función para obtener el tipo de la expresión
	def get_type
		return @type
	end
end