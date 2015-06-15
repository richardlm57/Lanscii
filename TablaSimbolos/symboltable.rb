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