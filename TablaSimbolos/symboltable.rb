class SymbolTable
	def initialize
		@table=Hash.new
	end
	def get_table	# Retorna el arreglo de tokens (o errores lexicográficos)
		return @table
	end
	def insert(key,value)
		@table[key]=value
	end
	def delete(key)
		@table.delete(key)
	end
	def update(key,value)
		insert(key,value)
	end
	def contains(key)
		return @table.has_key?(key)
	end
	def lookup(key)
		return @table[key]
	end
end