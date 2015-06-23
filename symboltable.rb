=begin

	@title	Clases para las tablas de símbolos de Lanscii

	@author	Richard Lares 11-10508
	@author	Oscar Guillen 11-11264

	@description Constructor y métodos definidos para las tablas de símbolos de Lanscii

=end

class SymbolTable 

	# Constructor
	def initialize	
		@table=Hash.new
		@father=nil
	end

	attr_accessor :table,:father

	# Método para insertar un elemento en la tabla
	def insert(key,value)
		result=@table[key]
		if result == nil
			@table[key]=value
			return true
		end
		return false
	end

	# Método para eliminar un elemento de la tabla
	def delete(key)
		@table.delete(key)
	end

	# Método para modificar un elemento de la tabla
	def update(key,value)
		insert(key,value)
	end

	# Método para verificar si un elemento de la tabla existe
	def contains(key)
		return @table.has_key?(key)
	end

	# Método para verificar el valor de un elemento de la tabla
	def lookup(key)
		result=@table[key]
		if result != nil
			return result
		else
			if @father != nil
				return @father.lookup(key)
			end
		end
		return nil
	end

	# Método de impresión de la tabla
	def to_s
		a=@table.to_a
		a.to_s
		for obj in a
			if obj[1] == :BOOL
				print "!"+obj[0]+" "
			end
			if obj[1] == :INT
				print "%"+obj[0]+" "
			end
			if obj[1] == :CANV
				print "@"+obj[0]+" "
			end
			if obj[1] == :CONT
				print "%"+obj[0]+" "
			end
		end
	end
end