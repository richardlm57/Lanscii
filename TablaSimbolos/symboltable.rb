class SymbolTable
	def initialize
		@table=Hash.new
		@father=nil
	end

	attr_accessor :table,:father

	def insert(key,value)
		result=@table[key]
		if result == nil
			@table[key]=value
			return true
		end
		return false
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
end