=begin

	@title	Clases para las producciones del parser de Lanscii

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description Declaración de clases (árboles) para las producciones del parser

=end
require './symboltable'
$st=SymbolTable.new
$vt=Hash.new
$e=Array.new

# Funcion para imprimir pipes.
def print_pipe(pipe)
	for i in 1..pipe
		print "|  "
	end
end

# Función para imprimir errores de tipo
def print_error(oper,type)
	if type == :INT || type == :CONT
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
		@table = $st
	end

	#Chequeo de tipos
	def check
		if $st.table != {}
			@table = SymbolTable.new
			@table.father = $st
			$st = @table
		end
		@declare.insertId
		if $e == []
			print "In line "+@curly[1].to_s+", column "+@curly[2].to_s+": "
			$st.to_s
			puts ""
		end
		@body.check
		if $st.father != nil
			$st = $st.father
		else
			if $e==[]
				return $vt
			end
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
		@table = $st
	end

	#Chequeo de tipos
	def check
		if $st.table != {}
			@table = SymbolTable.new
			@table.father = $st
			$st = @table
		end
		@body.check
		if $st.father != nil
			$st = $st.father
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
		if (($st.lookup(@id[0])==:CONT) || !($st.insert(@id[0],type)))
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
		if (($st.lookup(@id[0])==:CONT) || !($st.insert(@id[0],type)))
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
		if (($st.lookup(@id[0])==:CONT) || !($st.insert(@id[0],type)))
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+", '"+@id[0].to_s+"' is already declared")
		end
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
		noe=true
		tmp=$st.lookup(@id[0])
		if tmp==:CONT
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible modify a counter, '"+@id[0].to_s+"' is a counter")
			noe=false
		end
		if tmp == nil
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" in assignment, '"+@id[0].to_s+"' is not declared")
			noe=false
		else
			tmp2=@exp.get_type
			if tmp2!=nil
				if tmp!=tmp2
					if !((tmp==:INT || tmp==:CONT) && (tmp2==:INT || tmp2==:CONT))
					$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" in assignment, '"+tmp.to_s+"' type is incompatible with '"+tmp2.to_s+"'")
					noe=false
					end
				end
			end
		end
		if noe
			$vt[@id[0]]=@exp.get_value
		end
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
		t=$st.lookup(@id[0])
		if t==:CONT
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible modify a counter, '"+@id[0].to_s+"' is a counter")
		elsif t==:CANV
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible read a canvas, '"+@id[0].to_s+"' is a canvas")
		elsif t==nil
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" in read instruction, '"+@id[0].to_s+"' is not declared")
		else
			matchs=false
			while !matchs
				tmp=gets.chomp
				if tmp.match(/[0-9]+/)
					if t==:BOOL
						puts "Invalid value, please enter a value again"
					else
						$vt[@id[0]]=[tmp,0,0]
						mathcs=true
					end
				elsif tmp.match(/true|false/)
					if t==:INT
						puts "Invalid value, please enter a value again"
					else
						$vt[@id[0]]=[tmp,0,0]
						mathcs=true
					end
				else
					puts "Invalid value, please enter a value again"
				end
			end
			#print tmp.get_value
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
			elsif t == :INT or t == :CONT
				$e.push("Line: "+@oper[1].to_s+", Column: "+@oper[2].to_s+" write instruction expects type '@' but gets '%'")
			elsif t == nil
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
		t=@exp.get_type
		if t != :BOOL
			if t == :INT or t == :CONT
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '%'")
			elsif t == :CANV
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '@'")
			elsif t == nil
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" '"+@exp.id[0].to_s+"' is not declared")	
			end
		else
			if @exp.get_value.match(/true/)	
				@body.check
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
		t=@exp.get_type
		if t != :BOOL
			if t == :INT or t == :CONT
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '%'")
			elsif t == :CANV
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" conditional instruction expects type '!' but gets '@'")
			elsif t == nil
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" '"+@exp.id[0].to_s+"' is not declared")	
			end
		else
			if @exp.get_value.match(/true/)
				@body1.check
			elsif @exp.get_value.match(/false/)				
				@body2.check
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
		t=@exp.get_type
		if t!=:BOOL
			if t == :INT or t == :CONT
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" iteration instruction expects type '!' but gets '%'")
			elsif t == :CANV
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" iteration instruction expects type '!' but gets '@'")
			elsif t == nil
				$e.push("Line: "+@exp.get_oper[1].to_s+", Column: "+@exp.get_oper[2].to_s+" '"+@exp.id[0].to_s+"' is not declared")	
			end
		else
			if @exp.get_value.match(/true/)	
				while true
					@body.check
					# puts $vt
				end
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
		t1=@expr1.get_type
		t2=@expr2.get_type
		if t1!=:INT and t1!=:CONT
			if t1 == :BOOL
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t1 == :CANV
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t1 == nil
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" '"+@expr1.id[0].to_s+"' is not declared")	
			end
		elsif t2!=:INT and t2!=:CONT
			if t2 == :BOOL
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t2 == :CANV
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t2 == nil
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" '"+@expr2.id[0].to_s+"' is not declared")	
			end
		else
			[@expr2.get_value.to_i-@expr1.get_value.to_i,0].max.times do 
				@body.check	
			end
		end
	end
end


# Iteración con contador
class ID_ITER
	def initialize(val0,val1,val2,val3,val4)
		@lsquare = val0
		@id = val1
		@expr1 = val2
		@expr2 = val3
		@body = val4
		@table = $st
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
		if t1!=:INT and t1!=:CONT
			if t1 == :BOOL
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t1 == :CANV
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t1 == nil
				$e.push("Line: "+@expr1.get_oper[1].to_s+", Column: "+@expr1.get_oper[2].to_s+" '"+@expr1.id[0].to_s+"' is not declared")	
			end
		elsif t2!=:INT and t2!=:CONT
			if t2 == :BOOL
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '!'")
			elsif t2 == :CANV
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" iteration instruction expects type '%' but gets '@'")
			elsif t2 == nil
				$e.push("Line: "+@expr2.get_oper[1].to_s+", Column: "+@expr2.get_oper[2].to_s+" '"+@expr2.id[0].to_s+"' is not declared")	
			end
		elsif $st.lookup(@id[0])==:CONT
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" not possible modify a counter, '"+@id[0].to_s+"' is a counter")
		else
			if $st.table != {}
				@table = SymbolTable.new
				@table.father = $st
				$st = @table
			end
			$st.insert(@id[0],:CONT)
			if $e == []
				print "In line "+@lsquare[1].to_s+", column "+@lsquare[2].to_s+": "
				$st.to_s
				puts ""
			end
			$vt[@id[0]]=@expr1.get_value
			[@expr2.get_value.to_i-@expr1.get_value.to_i,0].max.times do 
				@body.check
				tmp=$vt[@id[0]]
				$vt[@id[0]]=(tmp.to_i+1).to_s
				puts $vt
			end
			$vt.delete(@id[0])
			if $st.father != nil
				$st = $st.father
			else
				return $e
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

	# Función para obtener el valor de la expresión
	def get_value
		return @exp.get_value
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

	def to_s(pipe)
		print_pipe(pipe)
		puts 'IDENTIFIER: ' + @id[0].to_s
	end

	# Función para obtener el valor de la expresión
	def get_value
		res=$vt[@id[0]]
		if res==nil
			$e.push("Line: "+@id[1].to_s+", Column: "+@id[2].to_s+" '"+@id[0]+"' is not been initialized")
		end
		return res
	end

	# Función para obtener el tipo de la expresión
	def get_type
		t=$st.lookup(@id[0])
		if  t != nil
			return t
		end
		return nil
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

	# Función para obtener el valor de la expresión
	def get_value
		return @value[0]
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

	# Función para obtener el valor de la expresión
	def get_value
		return @value[0]
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

# Expresiones de tipo lienzo
class EXP_CANVAS
	def initialize(val)
		@value = val
		@type = :CANV
	end

	def to_s(pipe)
		print_pipe(pipe)
		puts 'CANVAS: '+@value[0].to_s
	end

	# Función para obtener el valor de la expresión
	def get_value
		return @value[0]
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

	def to_s(pipe)
		print_pipe(pipe)
		pipe+=1
		puts 'OPERATION: ' + @oper[0].to_s
		@expr1.to_s(pipe)
		@expr2.to_s(pipe)
	end

	# Función para obtener el valor de la expresión
	def get_value
		tmp=@expr1.get_value
		tmp2=@expr2.get_value
		if tmp && tmp2
			if @oper[0].match(/\/\\/)
				return (eval(tmp) && eval(tmp2)).to_s
			elsif @oper[0].match(/\\\//)
				return (eval(tmp) || eval(tmp2)).to_s
			elsif @oper[0].match(/~/)
				return (eval(tmp) + eval(tmp2)).to_s
			elsif @oper[0].match(/\+|\-|\*|\/|%|<=|>=|<|>/)
				ec=tmp+@oper[0]+tmp2
				#puts ec
				return eval(ec).to_s
			elsif @oper[0].match(/\=/)
				return (eval(tmp) == eval(tmp2)).to_s
			elsif @oper[0].match(/\/=/)
				return (eval(tmp) != eval(tmp2)).to_s
			end	
			#elsif @oper[0].match(/&/)
		end
		return tmp
	end

	# Función para obtener el tipo de la expresión
	def get_type
		tmp=@expr1.get_type
		tmp2=@expr2.get_type
		if @oper[0].match(/\/\\|\\\//)
			if (tmp==:BOOL && tmp2==:BOOL)
				return :BOOL
			else
				$e.push(print_error(@oper,:BOOL))
				return nil
			end
		elsif @oper[0].match(/<=|>=|<|>/)
			if (tmp==:INT || tmp==:CONT) && (tmp2==:INT || tmp2==:CONT)
				return :BOOL
			else
				$e.push(print_error(@oper,:INT))
				return nil
			end
		elsif @oper[0].match(/\=|\/=/)
			if ((tmp==:INT || tmp==:CONT) && (tmp2==:INT || tmp2==:CONT)) || (tmp==:BOOL && tmp2==:BOOL) || (tmp==:CANV && tmp2==:CANV)
				return :BOOL
			else
				$e.push("Line: "+@oper[1].to_s+", Column: "+@oper[2].to_s+" in assignment, type '"+tmp.to_s+"' incompatible with '"+tmp2.to_s+"'")
				return nil
			end
		elsif @oper[0].match(/\+|\-|\*|\/|%/)
			if (tmp==:INT || tmp==:CONT) && (tmp2==:INT || tmp2==:CONT)
				return :INT
			else
				$e.push(print_error(@oper,:INT))
				return nil
			end
		elsif @oper[0].match(/&|~/)
			if (tmp==:CANV && tmp2==:CANV)
				return :CANV
			else
				$e.push(print_error(@oper,:CANV))
				return nil
			end
		end
	end

	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @oper
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

	# Función para obtener el valor de la expresión
	def get_value
		tmp=@expr.get_value
		if tmp
			if @oper[0].match(/\^/)
				return (!eval(tmp)).to_s
			end
			#elsif @oper[0].match(/'/)
		end
		return tmp
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

	# Función para obtener el valor de la expresión
	def get_value
		tmp=@expr.get_value
		if tmp
			if @oper[0].match(/-/)
				return (-eval(tmp)).to_s
			end
			#elsif @oper[0].match(/$/)
		end
		return tmp
	end
	# Función para obtener el operador de la expresión (si hay, si no se obtiene identificador o valor)
	def get_oper
		return @oper
	end

	# Función para obtener el tipo de la expresión
	def get_type
		tmp=@expr.get_type
		if @oper[0].match(/-/)
			if (tmp==:INT or tmp==:CONT)
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